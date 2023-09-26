import 'package:flutter/material.dart';

class OutlineInput extends TextField {
  OutlineInput({
    super.key,
    String? labelText,
    bool obscureText = false,
    TextEditingController? controller,
  }) : super(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        );
}
