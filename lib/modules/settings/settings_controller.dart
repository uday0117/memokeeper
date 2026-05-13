import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/constants/app_constants.dart';

/// Settings/Theme controller
class SettingsController extends GetxController {
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

  /// Get app version
  String get appVersion => AppConstants.appVersion;

  /// Get app name
  String get appName => AppConstants.appName;
}
