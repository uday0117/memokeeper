import 'package:get/get.dart';

import '../../routes/app_routes.dart';

/// Splash screen controller
class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  /// Navigate to home after delay
  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.home);
    });
  }
}
