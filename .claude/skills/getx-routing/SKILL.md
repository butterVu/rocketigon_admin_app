---
name: getx-routing
description: Use when adding or changing routes, GetPage, AppPages, navigation (Get.toNamed, Get.back, arguments) or route middleware with GetX.
---

## Routing with GetX

### Named Routes
* **Define Routes:** Centralize all routes in a routes file.
* **GetPage:** Use `GetPage` to configure routes with bindings.
* **Middleware:** Use `GetMiddleware` for route guards (auth, etc.).

```dart
// app/routes/app_routes.dart
abstract class Routes {
  static const home = '/home';
  static const login = '/login';
  static const profile = '/profile';
}

// app/routes/app_pages.dart
class AppPages {
  static const initial = Routes.home;
  
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
```

### Navigation
* **Get.toNamed:** Navigate to named route.
* **Get.offNamed:** Navigate and remove previous route.
* **Get.offAllNamed:** Navigate and clear stack.
* **Get.back:** Return to previous route.
* **Arguments:** Pass data using `arguments` parameter.

```dart
// Navigate with arguments
Get.toNamed(Routes.profile, arguments: {'userId': '123'});

// Receive arguments in controller
class ProfileController extends GetxController {
  late String userId;
  
  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments['userId'];
  }
}

// Navigate and wait for result
final result = await Get.toNamed(Routes.editor);
if (result != null) {
  // Handle result
}

// Return with result
Get.back(result: 'Updated successfully');
```

### Route Middleware
```dart
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    return authService.isAuthenticated ? null : const RouteSettings(name: Routes.login);
  }
}
```

