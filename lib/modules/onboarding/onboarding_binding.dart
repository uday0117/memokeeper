import 'package:get/get.dart';

import 'onboarding_controller.dart';

/// Onboarding binding
class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OnboardingController());
  }
}
