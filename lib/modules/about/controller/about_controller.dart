import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutController extends GetxController {
  final version = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadVersion();
  }

  Future<void> loadVersion() async {
    final info = await PackageInfo.fromPlatform();

    version.value = "${info.version} (${info.buildNumber})";
  }
}