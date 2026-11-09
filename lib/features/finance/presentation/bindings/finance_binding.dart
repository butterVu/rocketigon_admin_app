import 'package:get/get.dart';

import '../controllers/finance_controller.dart';

/// Registers the finance tab controller.
class FinanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(FinanceController.new);
  }
}
