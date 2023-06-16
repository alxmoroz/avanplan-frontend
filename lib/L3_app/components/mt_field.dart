// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons.dart';
import 'mt_button.dart';
import 'mt_field_data.dart';
import 'mt_list_tile.dart';
import 'text_widgets.dart';

class MTField extends StatelessWidget {
  const MTField(
    this.fd, {
    required this.onSelect,
    this.onReset,
    this.leading,
    this.value,
    this.bottomDivider = false,
    this.dividerStartIndent,
  });

  final MTFieldData fd;
  final Widget? leading;
  final Widget? value;
  final VoidCallback? onSelect;
  final VoidCallback? onReset;
  final bool bottomDivider;
  final double? dividerStartIndent;

  bool get _hasValue => value != null || fd.text.isNotEmpty;

  Widget? get _resetBtn => onReset != null && _hasValue
      ? MTButton.icon(
          const CloseIcon(color: lightGreyColor),
          onReset,
          padding: const EdgeInsets.symmetric(vertical: P_2).copyWith(left: P, right: 0),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    final Widget child = value ?? NormalText(fd.text);

    return Stack(
      alignment: Alignment.center,
      children: [
        MTListTile(
          leading: SizedBox(width: P3 + P_2, child: Center(child: leading)),
          middle: _hasValue ? NormalText(fd.label, color: lightGreyColor, height: 1, sizeScale: 0.9) : null,
          subtitle: _hasValue
              ? child
              : LightText(
                  fd.placeholder,
                  color: lightGreyColor,
                  padding: const EdgeInsets.symmetric(vertical: P_2),
                ),
          trailing: _resetBtn,
          bottomDivider: bottomDivider,
          dividerStartIndent: dividerStartIndent,
          onTap: onSelect,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        if (fd.loading) ...[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              color: backgroundColor.resolve(context).withAlpha(120),
            ),
          ),
          CircularProgressIndicator(color: mainColor.resolve(context)),
        ]
      ],
    );
  }
}
