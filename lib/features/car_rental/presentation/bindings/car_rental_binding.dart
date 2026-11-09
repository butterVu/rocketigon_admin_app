import 'package:get/get.dart';

import '../controllers/car_rental_controller.dart';

/// Registers the car rental tab controller.
class CarRentalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CarRentalController.new);
  }
}
