import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/initial_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'app/translations/app_translations.dart';
import 'core/constants/app_constants.dart';

void main() => runApp(const RocketigoAdminApp());

/// Root widget that configures theming and GetX routing.
class RocketigoAdminApp extends StatelessWidget {
  /// Creates the root [RocketigoAdminApp].
  const RocketigoAdminApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: AppConstants.appName,
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: ThemeMode.light, // Change to ThemeMode.dark for dark mode
    translations: AppTranslations(),
    locale: AppLanguage.vietnamese.locale,
    fallbackLocale: AppLanguage.english.locale,
    initialBinding: InitialBinding(),
    initialRoute: AppPages.initial,
    getPages: AppPages.routes,
  );
}
