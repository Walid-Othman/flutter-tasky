import 'package:flutter/material.dart';

class CustomeChickBox extends StatelessWidget {
  CustomeChickBox({super.key, required this.value, required this.onChanged});
  final bool value;
  final Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      visualDensity: VisualDensity.compact,

      activeColor: Color(0xFF15BB6C),

      value: value,
      onChanged: (value) => onChanged(value),
    );
  }
}
