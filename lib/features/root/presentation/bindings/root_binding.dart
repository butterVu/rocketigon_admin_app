import 'package:get/get.dart';

import '../../../account/presentation/bindings/account_binding.dart';
import '../controllers/root_controller.dart';

/// Registers the root screen and the controllers of all its tabs, since the
/// tabs live inside the root route instead of having routes of their own.
class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(RootController.new);
    AccountBinding().dependencies();
  }
}
