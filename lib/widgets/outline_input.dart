import 'package:flutter/material.dart';

class OutlineInput extends TextField {
  OutlineInput({
    super.key,
    this.labelText,
  }) : super(
          decoration: InputDecoration(
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        );

  final String? labelText;
}
