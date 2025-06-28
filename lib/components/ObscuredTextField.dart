import 'package:flutter/material.dart';

class ObscuredTextField extends StatefulWidget {
  final TextEditingController controller;

  const ObscuredTextField({required this.controller, super.key});

  @override
  State<ObscuredTextField> createState() => _ObscuredTextFieldState();
}

class _ObscuredTextFieldState extends State<ObscuredTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.controller,
        builder: (context, value, child) {
          return TextField(
            controller: widget.controller,
            style: const TextStyle(color: Colors.black),
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Transcript',
              labelStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 4),
              ),
            ),
          );
        },
      ),
    );
  }
}
