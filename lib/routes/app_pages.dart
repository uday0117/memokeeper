import 'package:get/get.dart';

import '../modules/add_note/add_note_binding.dart';
import '../modules/add_note/add_note_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/onboarding/onboarding_binding.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import 'app_routes.dart';

/// Application pages configuration
class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.addNote,
      page: () => const AddNoteView(),
      binding: AddNoteBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.editNote,
      page: () => const AddNoteView(),
      binding: AddNoteBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
