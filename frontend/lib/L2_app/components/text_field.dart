// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'material_wrapper.dart';
import 'text_widgets.dart';

OutlineInputBorder get _warningBorder => OutlineInputBorder(borderSide: BorderSide(color: warningColor));

OutlineInputBorder get _border => OutlineInputBorder(borderSide: BorderSide(color: borderColor));

InputDecoration _tfDecoration(String? label, String? helper, String? error, BuildContext context) => InputDecoration(
      labelText: label,
      labelStyle: NormalText('', weight: FontWeight.normal, color: darkGreyColor).style(context),
      helperText: helper,
      helperStyle: const SmallText('').style(context),
      errorText: error,
      errorStyle: SmallText('', color: warningColor).style(context),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      isDense: true,
      border: _border,
      enabledBorder: _border,
      errorBorder: _warningBorder,
      focusedErrorBorder: _warningBorder,
    );

class CTextField extends StatelessWidget {
  const CTextField({
    this.controller,
    this.label,
    this.description,
    this.error,
    this.keyboardType,
    this.maxLines,
    this.autofocus = true,
    this.margin,
    this.obscureText = false,
    this.capitalization,
  });

  final TextEditingController? controller;
  final String? label;
  final String? description;
  final String? error;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool autofocus;
  final EdgeInsetsGeometry? margin;
  final bool obscureText;
  final TextCapitalization? capitalization;

  @override
  Widget build(BuildContext context) {
    return material(Padding(
      padding: margin ?? const EdgeInsets.fromLTRB(14, 26, 14, 0),
      child: TextField(
          style: const H3('').style(context),
          decoration: _tfDecoration(label, description, error, context),
          autofocus: autofocus,
          maxLines: maxLines,
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: capitalization ?? TextCapitalization.sentences,
          obscureText: obscureText),
    ));
  }
}
