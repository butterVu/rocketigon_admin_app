import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:rocketigo_admin/app/translations/app_translations.dart';
import 'package:rocketigo_admin/features/auth/domain/usecases/logout_use_case.dart';
import 'package:rocketigo_admin/features/car_rental/presentation/controllers/car_rental_controller.dart';
import 'package:rocketigo_admin/features/finance/presentation/controllers/finance_controller.dart';
import 'package:rocketigo_admin/features/food/presentation/controllers/food_controller.dart';
import 'package:rocketigo_admin/features/root/presentation/bindings/root_binding.dart';
import 'package:rocketigo_admin/features/root/presentation/controllers/root_controller.dart';
import 'package:rocketigo_admin/features/root/presentation/views/root_view.dart';

class _LogoutUseCase implements LogoutUseCase {
  @override
  Future<void> call() async {}
}

void main() {
  setUp(() {
    Get.testMode = true;
    Get.put<LogoutUseCase>(_LogoutUseCase());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Root keeps Account as default and switches management tabs', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(
        translations: AppTranslations(),
        locale: const Locale('vi', 'VN'),
        initialBinding: RootBinding(),
        home: const RootView(),
      ),
    );
    await tester.pumpAndSettle();

    final root = Get.find<RootController>();
    expect(root.currentTab.value, RootTab.account);
    expect(find.text('Đăng xuất'), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(4));

    // Resolve the real bindings and retain these instances across tab changes.
    final food = Get.find<FoodController>();
    final carRental = Get.find<CarRentalController>();
    final finance = Get.find<FinanceController>();
    for (var round = 0; round < 2; round++) {
      for (final (label, tab) in [
        ('Đồ ăn', RootTab.food),
        ('Thuê xe', RootTab.carRental),
        ('Tài chính', RootTab.finance),
      ]) {
        await tester.tap(find.widgetWithText(NavigationDestination, label));
        await tester.pumpAndSettle();
        expect(root.currentTab.value, tab);
        expect(find.text(label), findsNWidgets(2));
        expect(find.text('Đăng xuất'), findsNothing);
        expect(tester.takeException(), isNull);
      }
      await tester.tap(find.widgetWithText(NavigationDestination, 'Tài khoản'));
      await tester.pumpAndSettle();
      expect(find.text('Đăng xuất'), findsOneWidget);
    }
    expect(Get.find<FoodController>(), same(food));
    expect(Get.find<CarRentalController>(), same(carRental));
    expect(Get.find<FinanceController>(), same(finance));
  });
}
