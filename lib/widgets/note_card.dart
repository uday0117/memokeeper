import 'package:flutter/material.dart';

import '../core/constants/note_colors.dart';
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
    final hasColor = note.colorCode != null;
    final gradient = NoteColors.getGradient(note.colorCode, isDark: isDark);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: hasColor ? gradient : null,
            color: hasColor ? null : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: note.isPinned
                ? Border.all(
                    color: hasColor
                        ? Colors.white.withOpacity(0.5)
                        : Theme.of(context).primaryColor.withOpacity(0.3),
                    width: 2,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: hasColor
                    ? Color(note.colorCode!).withOpacity(0.3)
                    : Colors.black.withOpacity(isDark ? 0.2 : 0.08),
                blurRadius: hasColor ? 16 : 12,
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
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            color: hasColor ? Colors.white : null,
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
                                ? (hasColor
                                      ? Colors.white
                                      : Theme.of(context).primaryColor)
                                : (hasColor
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.grey[400]!),
                            onPressed: onPin,
                            hasColoredBackground: hasColor,
                          ),
                          const SizedBox(width: 4),
                          _buildActionButton(
                            context,
                            icon: Icons.delete_outline_rounded,
                            color: hasColor
                                ? Colors.white.withOpacity(0.9)
                                : Colors.red[400]!,
                            onPressed: onDelete,
                            hasColoredBackground: hasColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Category and Tags
                  if (note.category != null ||
                      (note.tags != null && note.tags!.isNotEmpty))
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        // Category badge
                        if (note.category != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: hasColor
                                  ? Colors.white.withOpacity(0.25)
                                  : (isDark
                                        ? Colors.white.withOpacity(0.1)
                                        : Colors.grey[200]),
                              borderRadius: BorderRadius.circular(8),
                              border: hasColor
                                  ? Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    )
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  NoteCategories.getCategoryByName(
                                        note.category,
                                      )?.icon ??
                                      Icons.label_rounded,
                                  size: 12,
                                  color: hasColor
                                      ? Colors.white
                                      : (isDark
                                            ? Colors.grey[400]
                                            : Colors.grey[600]),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  note.category!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: hasColor
                                        ? Colors.white
                                        : (isDark
                                              ? Colors.grey[400]
                                              : Colors.grey[600]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        // Tag badges
                        if (note.tags != null)
                          ...note.tags!.map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: hasColor
                                    ? Colors.white.withOpacity(0.2)
                                    : (isDark
                                          ? Colors.white.withOpacity(0.08)
                                          : Colors.grey[100]),
                                borderRadius: BorderRadius.circular(8),
                                border: hasColor
                                    ? Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1,
                                      )
                                    : null,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.tag,
                                    size: 10,
                                    color: hasColor
                                        ? Colors.white.withOpacity(0.9)
                                        : (isDark
                                              ? Colors.grey[500]
                                              : Colors.grey[500]),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    tag,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: hasColor
                                          ? Colors.white.withOpacity(0.9)
                                          : (isDark
                                                ? Colors.grey[500]
                                                : Colors.grey[500]),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (note.category != null ||
                      (note.tags != null && note.tags!.isNotEmpty))
                    const SizedBox(height: 12),
                  // Content preview
                  if (note.content.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: hasColor
                            ? Colors.white.withOpacity(0.2)
                            : (isDark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.grey[100]),
                        borderRadius: BorderRadius.circular(12),
                        border: hasColor
                            ? Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              )
                            : null,
                      ),
                      child: Text(
                        note.content,
                        style: TextStyle(
                          fontSize: 14,
                          color: hasColor
                              ? Colors.white.withOpacity(0.95)
                              : (isDark ? Colors.grey[400] : Colors.grey[700]),
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
                          color: hasColor
                              ? Colors.white.withOpacity(0.2)
                              : (isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.grey[200]),
                          borderRadius: BorderRadius.circular(8),
                          border: hasColor
                              ? Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 14,
                              color: hasColor
                                  ? Colors.white.withOpacity(0.9)
                                  : (isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[600]),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              DateFormatter.getRelativeTime(note.updatedAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: hasColor
                                    ? Colors.white.withOpacity(0.9)
                                    : (isDark
                                          ? Colors.grey[400]
                                          : Colors.grey[600]),
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
                            color: hasColor
                                ? Colors.white.withOpacity(0.25)
                                : Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: hasColor
                                  ? Colors.white.withOpacity(0.4)
                                  : Theme.of(
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
                                color: hasColor
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                DateFormatter.formatDate(note.reminderDate!),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: hasColor
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
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
    bool hasColoredBackground = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: hasColoredBackground
                ? Colors.white.withOpacity(0.2)
                : color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: hasColoredBackground
                ? Border.all(color: Colors.white.withOpacity(0.3), width: 1)
                : null,
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}
