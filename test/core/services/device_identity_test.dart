import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rocketigo_admin/core/services/device_identity.dart';

/// [FlutterSecureStorage] that is never read: the device name does not use
/// it.
class _UnusedStorage implements FlutterSecureStorage {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  group('normalizeDeviceName', () {
    test('returns null for nothing or only spaces', () {
      expect(normalizeDeviceName(null), isNull);
      expect(normalizeDeviceName(''), isNull);
      expect(normalizeDeviceName('   '), isNull);
    });

    test('trims the spaces around the name', () {
      expect(normalizeDeviceName('  iPhone 15  '), 'iPhone 15');
    });

    test('keeps a name of exactly 100 characters', () {
      final name = 'a' * maxDeviceNameLength;

      expect(normalizeDeviceName(name), name);
    });

    test('cuts a longer name to 100 characters', () {
      final name = normalizeDeviceName('b' * 101);

      expect(name, 'b' * maxDeviceNameLength);
    });
  });

  group('SecureDeviceIdentity.deviceName', () {
    test('normalizes the name it reads', () async {
      final identity = SecureDeviceIdentity(
        _UnusedStorage(),
        readDeviceName: () async => '  Xiaomi 2201116TG ',
      );

      expect(await identity.deviceName(), 'Xiaomi 2201116TG');
    });

    test(
      'returns null instead of failing when the name cannot be read',
      () async {
        final identity = SecureDeviceIdentity(
          _UnusedStorage(),
          readDeviceName: () async => throw StateError('no plugin'),
        );

        expect(await identity.deviceName(), isNull);
      },
    );
  });
}
