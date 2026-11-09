import 'package:get/get.dart';

import '../../domain/usecases/login_use_case.dart';
import '../controllers/login_controller.dart';

/// Registers the dependencies of the login screen.
///
/// Requires `AuthRepositoryBinding`.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginUseCase(repository: Get.find()));
    Get.lazyPut(() => LoginController(loginUseCase: Get.find()));
  }
}
