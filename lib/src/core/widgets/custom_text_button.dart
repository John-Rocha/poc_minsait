import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    required this.label,
    super.key,
    this.onPressed,
    this.width,
    this.heigth,
  });

  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? heigth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heigth,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
