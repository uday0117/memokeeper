import 'package:get/get.dart';

import '../../data/models/note_model.dart';
import '../../data/services/hive_service.dart';
import '../../data/services/notification_service.dart';

/// Home screen controller
class HomeController extends GetxController {
  final HiveService _hiveService = HiveService();
  final NotificationService _notificationService = NotificationService();

  // Observable lists
  final RxList<NoteModel> allNotes = <NoteModel>[].obs;
  final RxList<NoteModel> filteredNotes = <NoteModel>[].obs;

  // Search query
  final RxString searchQuery = ''.obs;

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  /// Load all notes from database
  void loadNotes() {
    isLoading.value = true;
    try {
      final notes = _hiveService.getAllNotes();

      // Sort notes: pinned first, then by updated date (latest first)
      notes.sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.updatedAt.compareTo(a.updatedAt);
      });

      allNotes.value = notes;
      filteredNotes.value = notes;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load notes: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Search notes
  void searchNotes(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredNotes.value = allNotes;
    } else {
      final lowercaseQuery = query.toLowerCase();
      filteredNotes.value = allNotes.where((note) {
        return note.title.toLowerCase().contains(lowercaseQuery) ||
            note.content.toLowerCase().contains(lowercaseQuery);
      }).toList();
    }
  }

  /// Delete a note
  Future<void> deleteNote(String id) async {
    try {
      await _hiveService.deleteNote(id);

      // Cancel notification if exists
      final note = allNotes.firstWhere((n) => n.id == id);
      if (note.reminderDate != null) {
        await _notificationService.cancelNotification(id.hashCode);
      }

      loadNotes();
      Get.snackbar(
        'Success',
        'Note deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete note: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Delete all notes
  Future<void> deleteAllNotes() async {
    try {
      // Cancel all notifications
      for (var note in allNotes) {
        if (note.reminderDate != null) {
          await _notificationService.cancelNotification(note.id.hashCode);
        }
      }

      await _hiveService.deleteAllNotes();
      loadNotes();
      Get.snackbar(
        'Success',
        'All notes deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete all notes: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Toggle pin status
  Future<void> togglePin(NoteModel note) async {
    try {
      final updatedNote = note.copyWith(
        isPinned: !note.isPinned,
        updatedAt: DateTime.now(),
      );
      await _hiveService.updateNote(updatedNote);
      loadNotes();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update note: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Get empty state message
  String get emptyStateMessage {
    if (searchQuery.value.isNotEmpty) {
      return 'No notes found for "${searchQuery.value}"';
    }
    return 'No notes yet.\nTap + to create your first note!';
  }
}
