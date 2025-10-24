import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Future<void> Function()? onPressed;
  final Color? color;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed != null ? () async => await onPressed!() : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
