import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController Controller;
  final String title;
  final String hint;
  final String? Function(String?)? validator;
  final int maxLines; // 👈 خليها int واضحة

  const CustomTextFormField({
    super.key,
    required this.Controller,
    required this.title,
    required this.hint,
    required this.validator,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),

        TextFormField(
          maxLines: maxLines,
          controller: Controller,
          validator: validator,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xff282828),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}