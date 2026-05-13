import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/note_model.dart';
import '../../routes/app_routes.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/note_card.dart';
import 'home_controller.dart';

/// Home screen view
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo Keeper'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => Get.toNamed(AppRoutes.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          _buildSearchBar(),

          // Notes list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredNotes.isEmpty) {
                return EmptyState(message: controller.emptyStateMessage);
              }

              return RefreshIndicator(
                onRefresh: () async {
                  controller.loadNotes();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: controller.filteredNotes.length,
                  itemBuilder: (context, index) {
                    final note = controller.filteredNotes[index];
                    return NoteCard(
                      note: note,
                      onTap: () => _editNote(note),
                      onDelete: () => _confirmDelete(context, note.id),
                      onPin: () => controller.togglePin(note),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  /// Build search bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: controller.searchNotes,
        decoration: InputDecoration(
          hintText: 'Search notes...',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: Obx(
            () => controller.searchQuery.value.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    onPressed: () {
                      controller.searchNotes('');
                    },
                  )
                : controller.allNotes.isNotEmpty
                ? PopupMenuButton(
                    icon: const Icon(Icons.more_vert_rounded),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(Icons.delete_sweep_rounded),
                            SizedBox(width: 8),
                            Text('Delete All'),
                          ],
                        ),
                        onTap: () => _confirmDeleteAll(Get.context!),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  /// Add new note
  void _addNote() {
    Get.toNamed(AppRoutes.addNote)?.then((result) {
      if (result == true) {
        controller.loadNotes();
      }
    });
  }

  /// Edit existing note
  void _editNote(NoteModel note) {
    Get.toNamed(AppRoutes.editNote, arguments: note)?.then((result) {
      if (result == true) {
        controller.loadNotes();
      }
    });
  }

  /// Confirm delete single note
  void _confirmDelete(BuildContext context, String id) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteNote(id);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// Confirm delete all notes
  void _confirmDeleteAll(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.dialog(
        AlertDialog(
          title: const Text('Delete All Notes'),
          content: const Text(
            'Are you sure you want to delete all notes? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                controller.deleteAllNotes();
              },
              child: const Text(
                'Delete All',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    });
  }
}
