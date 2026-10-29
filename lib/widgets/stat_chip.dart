import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const StatChip({
    super.key,
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class SoftButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final Color dark;
  final IconData? icon;
  final bool outlined;

  const SoftButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.green,
    this.dark = AppColors.greenDark,
    this.icon,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: 54,
        decoration: BoxDecoration(
          color: outlined
              ? Colors.white
              : (enabled ? color : AppColors.line),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: outlined
                ? AppColors.line
                : (enabled ? dark : const Color(0xFFCFCFCF)),
            width: 2,
          ),
          boxShadow: enabled && !outlined
              ? [
                  BoxShadow(
                    color: dark,
                    offset: const Offset(0, 4),
                    blurRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: outlined ? AppColors.ink : Colors.white,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
                color: outlined
                    ? AppColors.ink
                    : (enabled ? Colors.white : AppColors.muted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
