// Copyright (c) 2022. Alexandr Moroz

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'icons.dart';
import 'mt_text_field.dart';
import 'text_widgets.dart';

class MTDropdown<T> extends StatefulWidget {
  const MTDropdown({
    required this.label,
    this.onChanged,
    this.value,
    this.ddItems,
    this.items,
    this.buttonHeight,
  }) : assert((ddItems == null && items != null) || (ddItems != null && items == null));

  final void Function(T?)? onChanged;
  final T? value;
  final List<T>? items;
  final List<DropdownMenuItem<T>>? ddItems;
  final String label;
  final double? buttonHeight;

  @override
  _MTDropdownState<T> createState() => _MTDropdownState();
}

class _MTDropdownState<T> extends State<MTDropdown<T>> {
  List<DropdownMenuItem<T>> get _ddItems =>
      widget.ddItems ??
      widget.items!
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: NormalText('$item'),
              ))
          .toList();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width - onePadding * 2;
    return Padding(
      padding: tfPadding,
      child: DropdownButtonFormField2<T>(
        decoration: tfDecoration(context, label: widget.label, readOnly: true),
        icon: downCaretIcon(context),
        items: _ddItems,
        value: widget.value,
        onChanged: widget.onChanged,
        dropdownWidth: width,
        dropdownPadding: EdgeInsets.symmetric(vertical: onePadding),
        dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(onePadding)),
        buttonHeight: widget.buttonHeight,
      ),
    );
  }
}
