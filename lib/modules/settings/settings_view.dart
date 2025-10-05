import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/localization_controller.dart';
import '../../l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final LocalizationController localizationController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.changeLanguage),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(loc.language),
            subtitle: Obx(() => Text(
              localizationController.locale.value.languageCode == 'bn' ? loc.bangla : loc.english,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
            trailing: DropdownButton<Locale>(
              value: localizationController.locale.value,
              items: [
                DropdownMenuItem(
                  value: LocalizationController.bangla,
                  child: Text(loc.bangla),
                ),
                DropdownMenuItem(
                  value: LocalizationController.english,
                  child: Text(loc.english),
                ),
              ],
              onChanged: (locale) {
                if (locale != null) {
                  localizationController.changeLocale(locale);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

