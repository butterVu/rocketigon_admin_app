---
name: flutter-ui
description: Use when designing UI, theming (light/dark, ColorScheme.fromSeed, theme switching), handling assets and images, or accessibility.
---

## Visual Design & Theming
* **UI Design:** Build beautiful and intuitive user interfaces that follow modern design guidelines.
* **Responsiveness:** Ensure the app is mobile responsive and adapts to different screen sizes.
* **Navigation:** Provide intuitive navigation using GetX routing.
* **Typography:** Stress and emphasize font sizes to ease understanding.
* **Shadows:** Multi-layered drop shadows create a strong sense of depth.
* **Icons:** Incorporate icons to enhance user understanding.
* **Interactive Elements:** Buttons and other elements have shadows with elegant use of color.

### Theming
* **Centralized Theme:** Define a centralized `ThemeData` object in `app/theme/` directory.
* **Light and Dark Themes:** Implement support for both themes.
* **Color Scheme Generation:** Generate harmonious color palettes using `ColorScheme.fromSeed`.
* **GetX Theme Switching:** Use GetX reactive variables to switch themes dynamically.

```dart
// app/theme/app_theme.dart
class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
  );
  
  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  );
}

// Controller for theme
class ThemeController extends GetxController {
  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  
  ThemeMode get theme => _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  
  void toggleTheme() => _isDarkMode.toggle();
}

// In main.dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    
    return Obx(() => GetMaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeController.theme,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        ));
  }
}
```

### Assets and Images
* **Asset Declaration:** Declare all asset paths in your `pubspec.yaml` file.
* **Local Images:** Use `Image.asset` for local images.
* **Network Images:** Use `Image.network` with `loadingBuilder` and `errorBuilder`.
* **Cached Images:** Use `cached_network_image` package for network images with caching.

## Accessibility (A11Y)
* **Color Contrast:** Ensure text has a contrast ratio of at least **4.5:1** against its background.
* **Dynamic Text Scaling:** Test your UI to ensure it remains usable when users increase the system font size.
* **Semantic Labels:** Use the `Semantics` widget to provide clear, descriptive labels.
* **Screen Reader Testing:** Regularly test with TalkBack (Android) and VoiceOver (iOS).

