import 'package:get/get.dart';

import '../../../auth/domain/usecases/logout_use_case.dart';
import '../../../auth/presentation/bindings/auth_repository_binding.dart';
import '../controllers/account_controller.dart';

/// Registers the dependencies of the account tab.
class AccountBinding extends Bindings {
  @override
  void dependencies() {
    AuthRepositoryBinding().dependencies();
    Get.lazyPut(() => LogoutUseCase(repository: Get.find()));
    Get.lazyPut(() => AccountController(logoutUseCase: Get.find()));
  }
}
