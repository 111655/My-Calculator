import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/theme/app_theme_type.dart';
import '../controller/settings_controller.dart';
import '../controller/theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ThemeController themeController = Get.find<ThemeController>();
  final settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Appearance
          /// Appearance
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Obx(
                    () => Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.palette_outlined),
                      title: Text(
                        "Appearance",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    RadioListTile<AppThemeType>(
                      title: const Text("☀ Light"),
                      value: AppThemeType.light,
                      groupValue: themeController.selectedTheme.value,
                      onChanged: (value) =>
                          themeController.changeTheme(value!),
                    ),

                    RadioListTile<AppThemeType>(
                      title: const Text("🌙 Dark"),
                      value: AppThemeType.dark,
                      groupValue: themeController.selectedTheme.value,
                      onChanged: (value) =>
                          themeController.changeTheme(value!),
                    ),

                    RadioListTile<AppThemeType>(
                      title: const Text("💙 Blue"),
                      value: AppThemeType.blue,
                      groupValue: themeController.selectedTheme.value,
                      onChanged: (value) =>
                          themeController.changeTheme(value!),
                    ),

                    RadioListTile<AppThemeType>(
                      title: const Text("💜 Purple"),
                      value: AppThemeType.purple,
                      groupValue: themeController.selectedTheme.value,
                      onChanged: (value) =>
                          themeController.changeTheme(value!),
                    ),

                    RadioListTile<AppThemeType>(
                      title: const Text("💚 Green"),
                      value: AppThemeType.green,
                      groupValue: themeController.selectedTheme.value,
                      onChanged: (value) =>
                          themeController.changeTheme(value!),
                    ),

                    RadioListTile<AppThemeType>(
                      title: const Text("⚫ AMOLED Black"),
                      value: AppThemeType.amoled,
                      groupValue: themeController.selectedTheme.value,
                      onChanged: (value) =>
                          themeController.changeTheme(value!),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// Haptic
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Obx(()=>SwitchListTile(
              secondary: const Icon(Icons.vibration),
              title: const Text("Haptic Feedback"),
              subtitle: const Text("Vibrate when buttons are pressed"),
              value: settingsController.hapticEnabled.value,
              onChanged: settingsController.toggleHaptic,
            ),
            ),
          ),

          const SizedBox(height: 12),

          /// Sound
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Obx(
                  () => SwitchListTile(
                secondary: const Icon(Icons.volume_up),
                title: const Text("Button Sound"),
                subtitle: const Text("Play sound when buttons are pressed"),
                value: settingsController.soundEnabled.value,
                onChanged: settingsController.toggleSound,
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// Decimal Precision
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Obx(
                  () => ListTile(
                leading: const Icon(Icons.calculate),
                title: const Text("Decimal Precision"),
                subtitle: Text(
                  settingsController.decimalPlaces.value == 0
                      ? "Auto"
                      : settingsController.decimalPlaces.value.toString(),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () async {
                  final int? value = await showDialog<int>(
                    context: context,
                    builder: (_) => SimpleDialog(
                      title: const Text("Decimal Precision"),
                      children: [
                        SimpleDialogOption(
                          onPressed: () => Navigator.pop(context, 0),
                          child: const Text("Auto"),
                        ),
                        SimpleDialogOption(
                          onPressed: () => Navigator.pop(context, 2),
                          child: const Text("2"),
                        ),
                        SimpleDialogOption(
                          onPressed: () => Navigator.pop(context, 4),
                          child: const Text("4"),
                        ),
                        SimpleDialogOption(
                          onPressed: () => Navigator.pop(context, 6),
                          child: const Text("6"),
                        ),
                      ],
                    ),
                  );

                  if (value != null) {
                    settingsController.setDecimal(value);
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Divider(),

          /// Share App
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Share App"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Share.share(
                "Try My Calculator App!\n\nBuilt with Flutter ❤️",
              );
            },
          ),

          /// Rate App
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text("Rate App"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Get.snackbar(
                "Coming Soon",
                "Available after Play Store release.",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),

          /// Privacy Policy
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text("Privacy Policy"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: const Text("Privacy Policy"),
                  content: const Text(
                    "This calculator stores your calculation history only on your device. "
                        "No personal information is collected or shared.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),

          /// About
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            subtitle: const Text("Version 1.0.0"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "My Calculator",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2026 Arvind Kumar",
              );
            },
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}