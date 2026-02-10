import 'package:flutter/material.dart';

class TapButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool filled;
  final IconData? icon;
  final double? width;

  const TapButton({
    super.key,
    required this.label,
    this.onPressed,
    this.filled = true,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final child = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 8),
              Text(label),
            ],
          )
        : Text(label);

    final button = filled
        ? FilledButton(onPressed: onPressed, child: child)
        : OutlinedButton(onPressed: onPressed, child: child);

    if (width != null) {
      return SizedBox(width: width, child: button);
    }
    return button;
  }
}
