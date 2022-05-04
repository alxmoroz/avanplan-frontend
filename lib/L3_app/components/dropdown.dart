// Copyright (c) 2022. Alexandr Moroz

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/remote_tracker.dart';
import 'circle.dart';
import 'colors.dart';
import 'constants.dart';
import 'icons.dart';
import 'text_field.dart';
import 'text_widgets.dart';

extension DropDownItem on RemoteTracker {
  Widget get dropDownItem => Row(
        children: [
          CircleWidget(color: connected ? Colors.green : warningColor, size: onePadding),
          NormalText(' $type $url'),
        ],
      );
}

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
      .map((item) => DropdownMenuItem<T>(
            value: item,
            child: item is RemoteTracker ? item.dropDownItem : NormalText('$item'),
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
