import 'package:get/get.dart';

import '../../data/datasources/session_local_data_source.dart';
import '../../data/repositories/session_repository_impl.dart';
import '../../domain/repositories/session_repository.dart';
import '../../domain/usecases/check_session_use_case.dart';
import '../controllers/splash_controller.dart';

/// Registers the dependencies of the splash screen.
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionLocalDataSource>(
      () => TokenSessionLocalDataSource(tokenStorage: Get.find()),
    );
    Get.lazyPut<SessionRepository>(
      () => SessionRepositoryImpl(localDataSource: Get.find()),
    );
    Get.lazyPut(() => CheckSessionUseCase(repository: Get.find()));
    // Not lazy: nothing in the view reads the controller, yet it must run.
    Get.put(SplashController(checkSession: Get.find()));
  }
}
