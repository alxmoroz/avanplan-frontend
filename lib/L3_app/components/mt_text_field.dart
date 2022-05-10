// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'material_wrapper.dart';
import 'text_widgets.dart';

InputDecoration tfDecoration(
  BuildContext context, {
  String? label,
  String? helper,
  String? error,
  Widget? suffixIcon,
  bool enabled = true,
  bool readOnly = false,
}) {
  final _rWarningColor = warningColor.resolve(context);
  final _rBorderColor = borderColor.resolve(context);

  final OutlineInputBorder _warningBorder = OutlineInputBorder(borderSide: BorderSide(color: _rWarningColor));
  final OutlineInputBorder _border = OutlineInputBorder(borderSide: BorderSide(color: _rBorderColor));

  return InputDecoration(
    labelText: label,
    labelStyle: const NormalText('', weight: FontWeight.normal, color: darkGreyColor).style(context),
    helperText: helper,
    helperStyle: const SmallText('').style(context),
    errorText: error,
    errorStyle: SmallText('', color: _rWarningColor).style(context),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    isDense: true,
    border: _border,
    focusedBorder: readOnly ? _border : null,
    enabledBorder: _border,
    disabledBorder: _border,
    errorBorder: _warningBorder,
    focusedErrorBorder: _warningBorder,
    suffixIcon: suffixIcon,
    enabled: enabled,
  );
}

EdgeInsets get tfPadding => EdgeInsets.fromLTRB(onePadding, onePadding * 2, onePadding, 0);

class MTTextField extends StatelessWidget {
  const MTTextField({
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
    this.autocorrect = false,
    this.suggestions = false,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
    this.enabled = true,
  });

  const MTTextField.noText({
    this.controller,
    this.label,
    this.description,
    this.error,
    this.margin,
    this.suffixIcon,
    this.onTap,
    this.enabled = true,
  })  : autofocus = false,
        maxLines = 1,
        obscureText = false,
        capitalization = null,
        autocorrect = false,
        suggestions = false,
        keyboardType = null,
        readOnly = true;

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
  final bool autocorrect;
  final bool suggestions;
  final bool readOnly;
  final bool enabled;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return material(Padding(
      padding: margin ?? tfPadding,
      child: TextField(
        style: const MediumText('').style(context),
        decoration: tfDecoration(
          context,
          label: label,
          helper: description,
          error: error,
          suffixIcon: suffixIcon,
          enabled: enabled,
          readOnly: readOnly,
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
      ),
    ));
  }
}
