library flutter_pulgin;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class CustomTextFromField extends StatefulWidget {
  TextEditingController textEditingController;
  String initialValue;
  TextInputType textInputType;
  TextCapitalization textCapitalization;
  TextStyle textStyle;

  CustomTextFromField(
      {super.key,
      required this.textEditingController,
      this.initialValue = "",
      this.textInputType = TextInputType.text,
      this.textCapitalization = TextCapitalization.none,
      this.textStyle= const TextStyle()
      });

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      initialValue: widget.initialValue,
      keyboardType: widget.textInputType,
      textCapitalization: widget.textCapitalization,
      style: widget.textStyle,
    );
  }
}
