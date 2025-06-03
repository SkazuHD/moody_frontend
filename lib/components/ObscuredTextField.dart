import 'package:flutter/material.dart';

class ObscuredTextField extends StatelessWidget {
  final TextEditingController controller;

  const ObscuredTextField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        controller: controller,
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
      ),
    );
  }
}
