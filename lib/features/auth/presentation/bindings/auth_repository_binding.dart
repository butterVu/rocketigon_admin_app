import 'package:get/get.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

/// Registers the [AuthRepository] shared by the sign-in screens.
class AuthRepositoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDataSource>(
      () => ApiAuthRemoteDataSource(client: Get.find()),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: Get.find(),
        tokenStorage: Get.find(),
        deviceIdentity: Get.find(),
      ),
    );
  }
}
