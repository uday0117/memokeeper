import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/note_model.dart';
import '../../routes/app_routes.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/note_card.dart';
import 'home_controller.dart';

/// Premium Home screen with modern design
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // Premium App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: isDark
                ? Theme.of(context).scaffoldBackgroundColor
                : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Memo Keeper',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      Theme.of(context).primaryColor.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.settings_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.settings),
                ),
              ),
            ],
          ),

          // Search bar
          SliverToBoxAdapter(child: _buildSearchBar(context)),

          // Notes list or empty state
          Obx(() {
            if (controller.isLoading.value) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (controller.filteredNotes.isEmpty) {
              return SliverFillRemaining(
                child: EmptyState(message: controller.emptyStateMessage),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final note = controller.filteredNotes[index];
                return NoteCard(
                  note: note,
                  onTap: () => _editNote(note),
                  onDelete: () => _confirmDelete(context, note.id),
                  onPin: () => controller.togglePin(note),
                );
              }, childCount: controller.filteredNotes.length),
            );
          }),

          // Bottom padding for FAB
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  /// Build premium search bar
  Widget _buildSearchBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: controller.searchNotes,
          decoration: InputDecoration(
            hintText: 'Search your notes...',
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.search_rounded,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
            suffixIcon: Obx(
              () => controller.searchQuery.value.isNotEmpty
                  ? IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close_rounded, size: 18),
                      ),
                      onPressed: () {
                        controller.searchNotes('');
                      },
                    )
                  : controller.allNotes.isNotEmpty
                  ? PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: Colors.grey[600],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_sweep_rounded,
                                color: Colors.red[400],
                              ),
                              const SizedBox(width: 12),
                              const Text('Delete All Notes'),
                            ],
                          ),
                          onTap: () => _confirmDeleteAll(Get.context!),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }

  /// Build premium FAB
  Widget _buildFAB(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: _addNote,
        elevation: 0,
        backgroundColor: Colors.transparent,
        icon: const Icon(Icons.add_rounded, size: 24),
        label: const Text(
          'New Note',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Delete Note',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to delete this note? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.deleteNote(id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Delete'),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_sweep_rounded,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Delete All Notes',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to delete ALL notes? This action cannot be undone and all your notes will be permanently lost.',
            style: TextStyle(height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                controller.deleteAllNotes();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Delete All'),
            ),
          ],
        ),
      );
    });
  }
}
