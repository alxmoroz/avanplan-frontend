// Copyright (c) 2022. Alexandr Moroz

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'filter_controller.dart';

class EWListSettings extends StatelessWidget {
  List<DropdownMenuItem<FilterVariant>> get ddItems => filterController.filterVariants.keys
      .map(
        (item) => DropdownMenuItem<FilterVariant>(
          value: item,
          child: NormalText(filterController.filterText(item)),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: onePadding),
        const Spacer(),
        Expanded(
          child: DropdownButtonFormField2<FilterVariant>(
            decoration: const InputDecoration(isDense: true, border: InputBorder.none),
            items: ddItems,
            value: filterController.filterVariant,
            icon: downCaretIcon(context),
            onChanged: (type) => filterController.setFilter(type),
            dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(onePadding)),
            isExpanded: true,
          ),
        ),
        SizedBox(width: onePadding),
      ],
    );
  }
}
