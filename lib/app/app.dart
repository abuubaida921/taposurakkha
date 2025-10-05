import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taposurakkha/app/routes.dart';
import 'package:taposurakkha/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../l10n/app_localizations.dart';
import 'localization_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController = Get.put(LocalizationController());
    return Obx(() => GetMaterialApp(
      title: 'তাপসুরক্ষা',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
      locale: localizationController.locale.value,
      supportedLocales: const [
        Locale('en'),
        Locale('bn'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    ));
  }
}