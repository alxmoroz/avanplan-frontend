import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/colors.dart';
import '../theme/text.dart';
import 'constants.dart';

InputDecoration tfDecoration(
    BuildContext context, {
      String? label,
      String? hint,
      String? helper,
      String? error,
      Widget? prefixIcon,
      Widget? suffixIcon,
      EdgeInsets? contentPadding,
      TextStyle? hintStyle,
      bool readOnly = false,
    }) {
  final bRadius = BorderRadius.circular(DEF_BORDER_RADIUS);
  final OutlineInputBorder warningBorder = OutlineInputBorder(borderSide: BorderSide(color: warningColor.resolve(context)), borderRadius: bRadius);
  final OutlineInputBorder border = OutlineInputBorder(borderSide: BorderSide(color: f3Color.resolve(context)), borderRadius: bRadius);
  final OutlineInputBorder focusedBorder =
  OutlineInputBorder(borderSide: BorderSide(width: 2, color: mainColor.resolve(context)), borderRadius: bRadius);

  return InputDecoration(
    labelText: label,
    labelStyle: const BaseText.f2('').style(context),
    hintText: hint,
    hintStyle: hintStyle ?? const BaseText.f3('').style(context),
    helperText: helper,
    helperStyle: const SmallText('').style(context),
    helperMaxLines: 3,
    errorText: error,
    errorStyle: const SmallText('', color: warningColor).style(context),
    errorMaxLines: 3,
    contentPadding: contentPadding ?? DEF_PADDING,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    isDense: true,
    border: border,
    focusedBorder: readOnly ? border : focusedBorder,
    enabledBorder: border,
    disabledBorder: border,
    errorBorder: warningBorder,
    focusedErrorBorder: warningBorder,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: b3Color.resolve(context),
  );
}

class MTTextField extends StatelessWidget {
  const MTTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.keyboardType,
    this.textInputAction,
    this.maxLines,
    this.minLines,
    this.autofocus = true,
    this.autofillHints,
    this.margin,
    this.contentPadding,
    this.obscureText = false,
    this.capitalization,
    this.autocorrect = true,
    this.suggestions = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChange,
    this.onSubmit,
    this.style,
    this.hintStyle,
    this.textAlign,
    this.decoration,
    this.focusNode,
    this.inputFormatters,
    this.cursorColor,
  });

  const MTTextField.noText({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.margin,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.decoration,
    this.maxLines = 1,
    this.minLines = 1,
    this.textAlign,
    this.focusNode,
  })  : autofocus = false,
        obscureText = false,
        capitalization = null,
        autocorrect = false,
        suggestions = false,
        keyboardType = null,
        onChange = null,
        onSubmit = null,
        style = null,
        inputFormatters = null,
        hintStyle = null,
        cursorColor = null,
        textInputAction = null,
        readOnly = true,
        autofillHints = null;

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final Iterable<String>? autofillHints;
  final EdgeInsets? margin;
  final EdgeInsets? contentPadding;
  final bool obscureText;
  final TextCapitalization? capitalization;
  final bool autocorrect;
  final bool suggestions;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Color? cursorColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? DEF_MARGIN,
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
                contentPadding: contentPadding,
                hintStyle: hintStyle,
              ),
          cursorColor: (cursorColor ?? mainColor).resolve(context),
          autofocus: autofocus,
          autofillHints: autofillHints,
          minLines: maxLines != null ? (minLines ?? 1) : null,
          maxLines: maxLines,
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: capitalization ?? TextCapitalization.sentences,
          obscureText: obscureText,
          autocorrect: autocorrect,
          enableSuggestions: suggestions,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChange,
          onSubmitted: onSubmit,
          focusNode: focusNode,
          textAlign: textAlign ?? TextAlign.start,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }
}
