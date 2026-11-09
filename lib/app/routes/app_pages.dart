import 'package:get/get.dart';

import '../../features/auth/presentation/bindings/auth_repository_binding.dart';
import '../../features/auth/presentation/bindings/login_binding.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/root/presentation/bindings/root_binding.dart';
import '../../features/root/presentation/views/root_view.dart';
import '../../features/splash/presentation/bindings/splash_binding.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../features/verify_otp/presentation/bindings/verify_otp_binding.dart';
import '../../features/verify_otp/presentation/views/verify_otp_view.dart';
import 'app_routes.dart';

/// Maps every [Routes] path to its page and binding.
abstract final class AppPages {
  /// Route opened when the app starts.
  static const initial = Routes.splash;

  /// All pages registered with `GetMaterialApp`.
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: Routes.root,
      page: () => const RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      bindings: [AuthRepositoryBinding(), LoginBinding()],
    ),
    GetPage(
      name: Routes.verifyOtp,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
  ];
}
