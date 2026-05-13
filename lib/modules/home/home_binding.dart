import 'package:get/get.dart';

import 'home_controller.dart';

/// Home screen binding
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
