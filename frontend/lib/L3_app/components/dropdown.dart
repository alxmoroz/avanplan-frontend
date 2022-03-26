// Copyright (c) 2022. Alexandr Moroz

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../extra/services.dart';
import 'constants.dart';
import 'icons.dart';
import 'text_field.dart';

class MTDropdown<T> extends StatelessWidget {
  const MTDropdown({
    required this.width,
    this.onChanged,
    this.value,
    this.items,
  });

  final double width;
  final void Function(T?)? onChanged;
  final T? value;
  final List<DropdownMenuItem<T>>? items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: tfPadding,
      child: DropdownButtonFormField2<T>(
        decoration: tfDecoration(context, label: loc.common_status_placeholder, readOnly: true),
        icon: downCaretIcon(context),
        items: items,
        value: value,
        onChanged: onChanged,
        dropdownWidth: width,
        dropdownPadding: EdgeInsets.symmetric(vertical: onePadding),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(onePadding),
        ),
      ),
    );
  }
}
