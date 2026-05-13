import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/app_routes.dart';

/// Onboarding controller
class OnboardingController extends GetxController {
  final GetStorage _storage = GetStorage();
  final PageController pageController = PageController();

  // Current page index
  final RxInt currentPage = 0.obs;

  // Total pages
  final int totalPages = 4;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page?.round() ?? 0;
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  /// Navigate to next page
  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  /// Skip to home
  void skip() {
    completeOnboarding();
  }

  /// Complete onboarding and navigate to home
  void completeOnboarding() {
    _storage.write('onboarding_completed', true);
    Get.offAllNamed(AppRoutes.home);
  }

  /// Check if onboarding is completed
  static bool isOnboardingCompleted() {
    final storage = GetStorage();
    return storage.read('onboarding_completed') ?? false;
  }
}
