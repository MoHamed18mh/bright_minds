import 'package:bright_minds/core/functions/validate_fields.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class PassWordFieldW extends StatefulWidget {
  const PassWordFieldW({super.key, this.controller, required this.text});

  final TextEditingController? controller;
  final String text;

  @override
  State<PassWordFieldW> createState() => _PassWordFieldWState();
}

class _PassWordFieldWState extends State<PassWordFieldW> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 16),
      controller: widget.controller,
      validator: validatFields,
      obscureText: _obscure,
      cursorColor: Colors.black,
      decoration: inputDecoration(),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      prefixIcon: const Icon(Icons.lock_open_outlined),
      prefixIconColor: AppColors.primaryColor,
      label: Text(
        widget.text,
        style: AppTextStyle.nunitoSansGrey,
      ),
      suffixIcon: suffixIcon(),
      suffixIconColor: AppColors.primaryColor,
      border: outLineInputBorder(),
      enabledBorder: outLineInputBorder(),
      focusedBorder: outLineInputBorder(),
      errorBorder: outLineInputBorder(),
    );
  }

  IconButton suffixIcon() {
    return IconButton(
      onPressed: () => setState(() => _obscure = !_obscure),
      icon: Icon(
        _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      ),
    );
  }

  OutlineInputBorder outLineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
    );
  }
}
