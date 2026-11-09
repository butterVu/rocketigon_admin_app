import 'package:get/get.dart';

import '../controllers/food_controller.dart';

/// Registers the food tab controller.
class FoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(FoodController.new);
  }
}
