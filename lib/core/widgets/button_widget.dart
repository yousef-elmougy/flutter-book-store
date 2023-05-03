import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    this.textStyle,
    this.backgroundColor,
    this.borderRadius,
    this.onPressed,
  });

  final String text;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor ?? Colors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: textStyle),
      );
}
