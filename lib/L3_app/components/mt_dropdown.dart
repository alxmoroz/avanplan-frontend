// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/base_entity.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'icons.dart';
import 'mt_text_field.dart';
import 'text_widgets.dart';

class MTDropdown<T extends RPersistable> extends StatelessWidget {
  const MTDropdown({
    required this.label,
    this.helper,
    this.onChanged,
    this.value,
    this.ddItems,
    this.items,
    this.margin,
    this.dense = true,
  }) : assert((ddItems == null && items != null) || (ddItems != null && items == null));

  final Function(int?)? onChanged;
  final int? value;
  final List<T>? items;
  final List<DropdownMenuItem<int>>? ddItems;
  final String label;
  final String? helper;
  final bool dense;
  final EdgeInsets? margin;

  List<DropdownMenuItem<int>> get _ddItems =>
      ddItems ??
      [
        for (final item in items!)
          DropdownMenuItem<int>(
            value: item.id,
            child: NormalText('$item'),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: DropdownButtonFormField<int>(
        dropdownColor: b3Color.resolve(context),
        focusColor: b3Color.resolve(context),
        isDense: dense,
        decoration: tfDecoration(context, label: label, helper: helper, readOnly: true),
        icon: const DropdownIcon(),
        items: _ddItems,
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS),
      ),
    );
  }
}
