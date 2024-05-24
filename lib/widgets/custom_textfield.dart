import 'package:flutter/material.dart';
import 'package:foodzoo/features/utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.onChanged,
    this.validatorText,
    this.textController,
    this.labelText,
    this.hintText,
    this.obscureText,
  });

  void Function(String)? onChanged;
  dynamic validatorText;
  dynamic labelText;
  dynamic hintText;
  bool? obscureText;
  TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return _customTextField(textController, hintText, validatorText, labelText,
        obscureText, onChanged);
  }

  Widget _customTextField(controller, hintText, validatorText, labelText,
      obscureText, void Function(String)? onChanged) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText ?? '',
        hintText: hintText ?? '',
        hintStyle: TextStyle(color: Colors.grey[400]),
        labelStyle: TextStyle(color: AppColors.appThemeColor),
        // #EBB22F
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.appThemeColor),
        ),
      ),
      onChanged: onChanged,
      obscureText: obscureText ?? false,
    );
  }
}
