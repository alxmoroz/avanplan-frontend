// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'linkify.dart';
import 'text.dart';
import 'text_field.dart';

class MTTextFieldInline extends StatelessWidget {
  const MTTextFieldInline(
    this.controller, {
    super.key,
    this.maxLines,
    this.style,
    this.hintStyle,
    this.hintText,
    required this.fNode,
    this.textInputAction,
    required this.onTap,
    this.onChanged,
    this.onSubmit,
  });

  final TextEditingController controller;
  final int? maxLines;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hintText;
  final FocusNode? fNode;
  final Function()? onTap;
  final Function(String str)? onChanged;
  final Function()? onSubmit;

  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final text = controller.text;
    final hasText = text.isNotEmpty;
    final textStyle = style ?? BaseText('', maxLines: maxLines).style(context);
    final hasFocus = fNode?.hasFocus == true;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Opacity(
          opacity: (hasFocus || !hasText) ? 1 : 0,
          child: MTTextField(
            textInputAction: textInputAction,
            controller: controller,
            autofocus: false,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: hintText,
              hintStyle: hintStyle ?? textStyle.copyWith(color: f3Color.resolve(context)),
            ),
            style: style,
            onChanged: onChanged,
            onSubmitted: onSubmit != null ? (_) => onSubmit!() : null,
            focusNode: fNode,
          ),
        ),
        if (hasText && !hasFocus)
          MTLinkify(
            text,
            maxLines: maxLines,
            style: textStyle,
            onTap: onTap,
          ),
      ],
    );
  }
}
