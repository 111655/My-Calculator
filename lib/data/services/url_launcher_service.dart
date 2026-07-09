import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  // ================= Privacy Policy =================

  static Future<void> openPrivacyPolicy() async {
    final Uri url = Uri.parse(
      "https://111655.github.io/my-calculator-privacy-policy/",
    );

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception("Could not open Privacy Policy.");
    }
  }

  // ================= Email =================

  static Future<void> sendEmail() async {
    final Uri email = Uri(
      scheme: 'mailto',
      path: 'arvindkumar11652@gmail.com',
      queryParameters: {
        'subject': 'My Calculator',
      },
    );

    if (!await launchUrl(email)) {
      throw Exception("Could not open email.");
    }
  }

  // ================= LinkedIn =================

  static Future<void> openLinkedIn() async {
    final Uri url = Uri.parse(
      "https://www.linkedin.com/in/arvind-kumar-gupta-03b7b2269",
    );

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception("Could not open LinkedIn.");
    }
  }

  // ================= Share App =================

  static Future<void> shareApp() async {
    await SharePlus.instance.share(
      ShareParams(
        text:
        "Check out My Calculator!\n\n"
            "https://play.google.com/store/apps/details?id=YOUR_PACKAGE_NAME",
      ),
    );
  }

  // ================= Rate App =================

  static Future<void> rateApp() async {
    final Uri url = Uri.parse(
      "https://play.google.com/store/apps/details?id=YOUR_PACKAGE_NAME",
    );

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception("Could not open Play Store.");
    }
  }
}