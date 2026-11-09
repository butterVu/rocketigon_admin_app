import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';

/// Row of the account menu with an icon, a title and a chevron.
class AccountMenuTile extends StatelessWidget {
  /// Creates an [AccountMenuTile].
  const AccountMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = AppColor.primary,
  });

  /// Icon shown before [title].
  final IconData icon;

  /// Name of the menu entry.
  final String title;

  /// Called when the row is tapped.
  final VoidCallback onTap;

  /// Color of the icon, e.g. [AppColor.error] for destructive actions.
  final Color color;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(title, style: AppTextStyle.medium16())),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColor.textSecondary,
          ),
        ],
      ),
    ),
  );
}
