import 'package:flutter/material.dart';

import '../core/utils/date_formatter.dart';
import '../data/models/note_model.dart';

/// Premium note card widget with modern design
class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
    required this.onPin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: note.isPinned
                ? Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    width: 2,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title and actions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pin indicator
                      if (note.isPinned)
                        Container(
                          margin: const EdgeInsets.only(top: 2, right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor.withOpacity(0.7),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.push_pin_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      // Title
                      Expanded(
                        child: Text(
                          note.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Actions
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildActionButton(
                            context,
                            icon: note.isPinned
                                ? Icons.push_pin_rounded
                                : Icons.push_pin_outlined,
                            color: note.isPinned
                                ? Theme.of(context).primaryColor
                                : Colors.grey[400]!,
                            onPressed: onPin,
                          ),
                          const SizedBox(width: 4),
                          _buildActionButton(
                            context,
                            icon: Icons.delete_outline_rounded,
                            color: Colors.red[400]!,
                            onPressed: onDelete,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Content preview
                  if (note.content.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        note.content,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.grey[700],
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ] else
                    const SizedBox(height: 8),

                  // Footer with date and reminder
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withOpacity(0.1)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 14,
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              DateFormatter.getRelativeTime(note.updatedAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Reminder badge
                      if (note.reminderDate != null &&
                          note.reminderDate!.isAfter(DateTime.now()))
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor.withOpacity(0.2),
                                Theme.of(context).primaryColor.withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.notifications_active_rounded,
                                size: 14,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                DateFormatter.formatDate(note.reminderDate!),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build action button
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}
