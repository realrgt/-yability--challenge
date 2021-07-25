import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String label;
  final FormFieldSetter<String> onSaved;
  final TextInputType? keyboardType;

  const CustomTextFieldWidget({
    Key? key,
    required this.label,
    required this.onSaved,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.green),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
      onSaved: onSaved,
    );
  }
}
