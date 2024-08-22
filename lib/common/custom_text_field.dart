import 'package:flutter/material.dart';
import 'package:piethostel/common/my_form_field.dart';

class CustomTextField extends StatelessWidget {
  final int? maxLines, minLines;
  final String? inputHint;
  final Widget? suffixIcon, prefixIcon;
  final bool? obscureText;
  final TextInputType? inputKeyBoardType;
  final Color? inputFillColor;
  final InputBorder? border, focusedBorder, enabledBorder;
  final Function()? pressMe;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  const CustomTextField({
    super.key,
    this.maxLines,
    this.minLines,
    this.inputHint,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.inputKeyBoardType,
    this.inputFillColor,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.pressMe,
    this.validator,
    this.controller,
    this.hintStyle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyFormField(
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green.shade400,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
            maxLines: maxLines ?? 1,
            minLines: minLines ?? 1,
            controller: controller,
            validator: validator,
            inputFilled: true,
            inputFillColor: inputFillColor ?? Colors.white,
            inputHint: inputHint,
            obscureText: obscureText,
            inputKeyboardType: inputKeyBoardType,
            contentPadding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 19,
              right: 22,
            ),
            border: border ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green.shade400,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: suffixIcon,
            ),
            onChanged: onChanged,
            prefixIcon: prefixIcon,
            inputTextStyle: const TextStyle(
              color: Color(0xFF0B2C47),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            inputHintStyle: hintStyle ??
                const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
