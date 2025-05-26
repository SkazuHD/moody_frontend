import 'package:flutter/material.dart';

final ButtonStyle greyButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFFCFCFCF),
  foregroundColor: Colors.black,
  minimumSize: const Size(200, 40),
  textStyle: const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  ),
);

class GreyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const GreyButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: greyButtonStyle,
      onPressed: onPressed,
      child: Text(text), // Style kommt vom ButtonStyle
    );
  }
}
