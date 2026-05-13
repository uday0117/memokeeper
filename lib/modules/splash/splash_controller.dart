import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../onboarding/onboarding_controller.dart';

/// Splash screen controller
class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  /// Navigate to onboarding or home based on first launch
  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      if (OnboardingController.isOnboardingCompleted()) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.onboarding);
      }
    });
  }
}
