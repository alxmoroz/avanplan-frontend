// Copyright (c) 2022. Alexandr Moroz

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'icons.dart';
import 'text_field.dart';
import 'text_widgets.dart';

class MTDropdown<T> extends StatefulWidget {
  const MTDropdown({
    required this.width,
    required this.items,
    required this.label,
    this.onChanged,
    this.value,
  });

  final double width;
  final void Function(T?)? onChanged;
  final T? value;
  final List<T> items;
  final String label;

  @override
  _MTDropdownState<T> createState() => _MTDropdownState();
}

class _MTDropdownState<T> extends State<MTDropdown<T>> {
  List<DropdownMenuItem<T>> get ddItems => widget.items
      .map((s) => DropdownMenuItem<T>(
            value: s,
            child: NormalText('$s'),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: tfPadding,
      child: DropdownButtonFormField2<T>(
        decoration: tfDecoration(context, label: widget.label, readOnly: true),
        icon: downCaretIcon(context),
        items: ddItems,
        value: widget.value,
        onChanged: widget.onChanged,
        dropdownWidth: widget.width,
        dropdownPadding: EdgeInsets.symmetric(vertical: onePadding),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(onePadding),
        ),
      ),
    );
  }
}
