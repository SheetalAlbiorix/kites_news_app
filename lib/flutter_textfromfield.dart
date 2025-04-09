library flutter_pulgin;

import 'package:flutter/material.dart';


/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class CustomTextFromField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputType? textInputType;
  final TextCapitalization textCapitalization;
  final TextStyle? textStyle;

  const CustomTextFromField(
      {super.key,
      required this.textEditingController,
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
      keyboardType: widget.textInputType,
      textCapitalization: widget.textCapitalization,
      style: widget.textStyle,
      decoration: Input_Decoration().none(),
    );
  }
}






class CustomTextField{

  Widget none({required TextEditingController textEditingController,
    TextInputType textInputType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle textStyle = const TextStyle()
  }){
    return TextFormField(
      controller: textEditingController,
      keyboardType: textInputType,
      textCapitalization: textCapitalization,
      style: textStyle,
      decoration: Input_Decoration().none(),
    );
  }
}


class Input_Decoration{
  InputDecoration? none(){
    return  InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Enter your username',
    );
  }
}
