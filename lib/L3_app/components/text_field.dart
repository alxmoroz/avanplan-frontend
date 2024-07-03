// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'text.dart';

InputDecoration tfDecoration(
  BuildContext context, {
  String? label,
  String? hint,
  String? helper,
  String? error,
  Widget? prefixIcon,
  Widget? suffixIcon,
  EdgeInsets? padding,
  bool readOnly = false,
}) {
  final bRadius = BorderRadius.circular(DEF_BORDER_RADIUS);
  final OutlineInputBorder dangerBorder = OutlineInputBorder(borderSide: BorderSide(color: dangerColor.resolve(context)), borderRadius: bRadius);
  final OutlineInputBorder border = OutlineInputBorder(borderSide: BorderSide(color: f3Color.resolve(context)), borderRadius: bRadius);
  final OutlineInputBorder focusedBorder =
      OutlineInputBorder(borderSide: BorderSide(width: 2, color: mainColor.resolve(context)), borderRadius: bRadius);

  return InputDecoration(
    labelText: label,
    labelStyle: const BaseText.f2('').style(context),
    hintText: hint,
    hintStyle: const BaseText.f3('').style(context),
    helperText: helper,
    helperStyle: const SmallText('').style(context),
    helperMaxLines: 3,
    errorText: error,
    errorStyle: const SmallText('', color: dangerColor).style(context),
    errorMaxLines: 3,
    contentPadding: padding,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    isDense: true,
    border: border,
    focusedBorder: readOnly ? border : focusedBorder,
    enabledBorder: border,
    disabledBorder: border,
    errorBorder: dangerBorder,
    focusedErrorBorder: dangerBorder,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: b3Color.resolve(context),
  );
}

EdgeInsets get tfPadding => const EdgeInsets.fromLTRB(P2, P3, P2, 0);

class MTTextField extends StatelessWidget {
  const MTTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.keyboardType,
    this.maxLines,
    this.autofocus = true,
    this.margin,
    this.padding,
    this.obscureText = false,
    this.capitalization,
    this.autocorrect = true,
    this.suggestions = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.style,
    this.decoration,
    this.focusNode,
  });

  const MTTextField.noText({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.margin,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.decoration,
    this.maxLines = 1,
    this.focusNode,
  })  : autofocus = false,
        obscureText = false,
        capitalization = null,
        autocorrect = false,
        suggestions = false,
        keyboardType = null,
        onChanged = null,
        onSubmitted = null,
        style = null,
        readOnly = true;

  final TextEditingController? controller;
  final String? label;
  final String? hint;
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
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? tfPadding,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        removeRight: true,
        removeLeft: true,
        child: TextField(
          style: style ?? const BaseText('').style(context),
          decoration: decoration ??
              tfDecoration(
                context,
                label: label,
                hint: hint,
                helper: helper,
                error: error,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                readOnly: readOnly,
                padding: padding,
              ),
          cursorColor: mainColor.resolve(context),
          autofocus: autofocus,
          minLines: 1,
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
          onSubmitted: onSubmitted,
          focusNode: focusNode,
        ),
      ),
    );
  }
}
