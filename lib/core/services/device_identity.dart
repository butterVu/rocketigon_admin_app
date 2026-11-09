import 'dart:developer' as developer;
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Longest device name the server accepts.
const maxDeviceNameLength = 100;

/// Trims [raw] and cuts it to [maxDeviceNameLength] characters, or returns
/// `null` when nothing is left.
String? normalizeDeviceName(String? raw) {
  final trimmed = raw?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  return trimmed.length <= maxDeviceNameLength
      ? trimmed
      : trimmed.substring(0, maxDeviceNameLength).trim();
}

/// Identifies this installation to the server, which trusts known devices
/// and asks unknown ones for an OTP.
abstract interface class DeviceIdentity {
  /// Stable id of this installation, created on first use.
  Future<String> deviceId();

  /// Model of the phone, e.g. `Samsung SM-S921B`, shown in the list of
  /// trusted devices; `null` when it cannot be read.
  Future<String?> deviceName();
}

/// [DeviceIdentity] keeping a random UUID v4 in secure storage, so it
/// survives sign-out and app updates.
///
/// Hardware ids such as IMEI or MAC are never used.
class SecureDeviceIdentity implements DeviceIdentity {
  /// Creates a [SecureDeviceIdentity] persisting to [storage].
  ///
  /// [readDeviceName] gives the model of the phone, the platform one by
  /// default.
  SecureDeviceIdentity(
    this._storage, {
    Random? random,
    Future<String?> Function()? readDeviceName,
  }) : _random = random ?? Random.secure(),
       _readDeviceName = readDeviceName ?? _readPlatformDeviceName;

  final FlutterSecureStorage _storage;
  final Random _random;
  final Future<String?> Function() _readDeviceName;
  Future<String>? _deviceId;

  static const _deviceIdKey = 'device.id';

  @override
  Future<String> deviceId() => _deviceId ??= _readOrCreate();

  @override
  Future<String?> deviceName() async {
    try {
      return normalizeDeviceName(await _readDeviceName());
    } catch (error, stackTrace) {
      developer.log(
        'Reading the device name failed',
        name: 'rocket.device',
        level: 900,
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Model of the phone read from the platform: manufacturer and model on
  /// Android, the hardware identifier (e.g. `iPhone15,2`) on iOS.
  static Future<String?> _readPlatformDeviceName() async {
    final plugin = DeviceInfoPlugin();
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => switch (await plugin.androidInfo) {
        AndroidDeviceInfo(:final manufacturer, :final model) =>
          '$manufacturer $model',
      },
      TargetPlatform.iOS => (await plugin.iosInfo).utsname.machine,
      _ => null,
    };
  }

  Future<String> _readOrCreate() async {
    final stored = await _storage.read(key: _deviceIdKey);
    if (stored != null) return stored;
    final created = _uuidV4();
    await _storage.write(key: _deviceIdKey, value: created);
    return created;
  }

  String _uuidV4() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = [
      for (final byte in bytes) byte.toRadixString(16).padLeft(2, '0'),
    ].join();
    return [
      hex.substring(0, 8),
      hex.substring(8, 12),
      hex.substring(12, 16),
      hex.substring(16, 20),
      hex.substring(20),
    ].join('-');
  }
}
