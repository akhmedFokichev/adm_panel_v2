import 'package:flutter/material.dart';

class ProfileInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;

  const ProfileInput({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}
