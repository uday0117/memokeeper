import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/app_constants.dart';

/// Theme controller for managing app theme
class ThemeController extends GetxController {
  final GetStorage _storage = GetStorage();

  // Observable for dark mode
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  /// Load theme preference from storage
  void _loadThemePreference() {
    isDarkMode.value = _storage.read(AppConstants.isDarkModeKey) ?? false;
  }

  /// Toggle theme mode
  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    await _storage.write(AppConstants.isDarkModeKey, isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
