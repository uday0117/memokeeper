import 'package:get/get.dart';

import 'add_note_controller.dart';

/// Add/Edit note binding
class AddNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNoteController>(() => AddNoteController());
  }
}
