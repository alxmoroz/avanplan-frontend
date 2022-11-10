// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'constants.dart';
import 'icons.dart';
import 'mt_text_field.dart';
import 'text_widgets.dart';

class MTDropdown<T> extends StatelessWidget {
  const MTDropdown({
    required this.label,
    this.onChanged,
    this.value,
    this.ddItems,
    this.items,
    this.dense = true,
  }) : assert((ddItems == null && items != null) || (ddItems != null && items == null));

  final void Function(T?)? onChanged;
  final T? value;
  final List<T>? items;
  final List<DropdownMenuItem<T>>? ddItems;
  final String label;
  final bool dense;

  List<DropdownMenuItem<T>> get _ddItems =>
      ddItems ??
      items!
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: NormalText('$item'),
              ))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: tfPadding,
      child: DropdownButtonFormField<T>(
        isDense: dense,
        decoration: tfDecoration(context, label: label, readOnly: true),
        icon: const DropdownIcon(),
        items: _ddItems,
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        borderRadius: BorderRadius.circular(P_2),
      ),
    );
  }
}
