import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/url_launcher_service.dart';
import '../controller/about_controller.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});

  final AboutController controller =
  Get.put(AboutController());

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text("About"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [

                  Image.asset(
                    "assets/images/appicon.png",
                    width: 80,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "My Calculator",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Obx(() => Text(
                    "Version ${controller.version.value}",
                  )),

                  const SizedBox(height: 12),

                  Text(
                    "Smart • Fast • Accurate",
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [

                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: const Text(
                      "Developer",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Arvind Kumar Gupta"),
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.business),
                    title: const Text("Published by"),
                    subtitle: const Text("WhereIs"),
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: const Text("Email"),
                    subtitle: const Text(
                      "arvindkumar11652@gmail.com",
                    ),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () {
                      UrlLauncherService.sendEmail();
                    },
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: const Text("LinkedIn"),
                    subtitle: const Text(
                      "Arvind Kumar Gupta",
                    ),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () {
                      UrlLauncherService.openLinkedIn();
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [

                /// Rate App
                ListTile(
                  leading: const Icon(Icons.star_rate_rounded),
                  title: const Text("Rate App"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    UrlLauncherService.rateApp();
                  },
                ),

                const Divider(height: 1),

                /// Share App
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text("Share App"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    UrlLauncherService.shareApp();
                  },
                ),

                const Divider(height: 1),

                /// Privacy Policy
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text("Privacy Policy"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    UrlLauncherService.openPrivacyPolicy();
                  },
                ),

                const Divider(height: 1),

                /// Open Source Licenses
                ListTile(
                  leading: const Icon(Icons.article_outlined),
                  title: const Text("Open Source Licenses"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    showLicensePage(
                      context: context,
                      applicationName: "My Calculator",
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Center(
            child: Column(
              children: [

                Text(
                  "Made with ❤️ using Flutter",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "© 2026 WhereIs",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "All Rights Reserved.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}