import 'package:flutter/material.dart';

class CustomeTextFormFild extends StatelessWidget {
  const CustomeTextFormFild({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.validator,
    required this.title,
    this.maxLength,
  });
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final validator;
  final String title;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontSize: 16),
        ),
        SizedBox(height: 10),
        TextFormField(
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(hintText: hintText),
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontSize: 16),

          controller: controller,
          validator: (String? value) {
            if ((value == null || value.trim().isEmpty) && validator != null) {
              return validator(value);
            }
            return null;
          },
        ),
      ],
    );
  }
}
