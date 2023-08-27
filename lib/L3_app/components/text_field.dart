// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'material_wrapper.dart';
import 'text.dart';

InputDecoration tfDecoration(
  BuildContext context, {
  String? label,
  String? helper,
  String? error,
  Widget? prefixIcon,
  Widget? suffixIcon,
  EdgeInsets? padding,
  bool readOnly = false,
}) {
  final _rWarningColor = warningColor.resolve(context);
  final _rBorderColor = f3Color.resolve(context);

  final OutlineInputBorder _warningBorder = OutlineInputBorder(borderSide: BorderSide(color: _rWarningColor));
  final OutlineInputBorder _border = OutlineInputBorder(borderSide: BorderSide(color: _rBorderColor));
  final OutlineInputBorder _focusedBorder = OutlineInputBorder(borderSide: BorderSide(width: 2, color: mainColor.resolve(context)));

  return InputDecoration(
    labelText: label,
    labelStyle: const LightText('', color: f2Color).style(context),
    helperText: helper,
    helperStyle: const SmallText('').style(context),
    helperMaxLines: 15,
    errorText: error,
    errorStyle: const SmallText('', color: warningColor).style(context),
    errorMaxLines: 15,
    contentPadding: padding,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    isDense: true,
    border: _border,
    focusedBorder: readOnly ? _border : _focusedBorder,
    enabledBorder: _border,
    disabledBorder: _border,
    errorBorder: _warningBorder,
    focusedErrorBorder: _warningBorder,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: b3Color.resolve(context),
  );
}

EdgeInsets get tfPadding => const EdgeInsets.fromLTRB(P, P2, P, 0);

class MTTextField extends StatelessWidget {
  const MTTextField({
    this.controller,
    this.label,
    this.helper,
    this.error,
    this.keyboardType,
    this.maxLines,
    this.autofocus = true,
    this.margin,
    this.padding,
    this.obscureText = false,
    this.capitalization,
    this.autocorrect = false,
    this.suggestions = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.style,
    this.decoration,
  });

  const MTTextField.noText({
    this.controller,
    this.label,
    this.helper,
    this.error,
    this.margin,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.decoration,
    this.maxLines = 1,
  })  : autofocus = false,
        obscureText = false,
        capitalization = null,
        autocorrect = false,
        suggestions = false,
        keyboardType = null,
        onChanged = null,
        style = null,
        readOnly = true;

  final TextEditingController? controller;
  final String? label;
  final String? helper;
  final String? error;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool autofocus;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool obscureText;
  final TextCapitalization? capitalization;
  final bool autocorrect;
  final bool suggestions;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputDecoration? decoration;
  final TextStyle? style;
  final VoidCallback? onTap;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return material(
      Padding(
        padding: margin ?? tfPadding,
        child: TextField(
          style: style ?? const NormalText('').style(context),
          decoration: decoration ??
              tfDecoration(
                context,
                label: label,
                helper: helper,
                error: error,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                readOnly: readOnly,
                padding: padding,
              ),
          cursorColor: mainColor.resolve(context),
          autofocus: autofocus,
          maxLines: maxLines,
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: capitalization ?? TextCapitalization.sentences,
          obscureText: obscureText,
          autocorrect: autocorrect,
          enableSuggestions: suggestions,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
