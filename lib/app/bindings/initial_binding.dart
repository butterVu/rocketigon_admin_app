import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../core/network/api_client.dart';
import '../../core/network/dio_factory.dart';
import '../../core/services/device_identity.dart';
import '../../core/services/token_storage.dart';
import '../routes/app_routes.dart';

/// Registers app-wide dependencies (services, repositories) at startup.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    const secureStorage = FlutterSecureStorage();
    final tokenStorage = Get.put<TokenStorage>(
      const SecureTokenStorage(secureStorage),
      permanent: true,
    );
    Get.put<DeviceIdentity>(
      SecureDeviceIdentity(secureStorage),
      permanent: true,
    );
    Get.put(
      ApiClient(
        DioFactory.create(
          tokenStorage: tokenStorage,
          onSessionExpired: () => Get.offAllNamed<void>(Routes.login),
        ),
      ),
      permanent: true,
    );
  }
}
