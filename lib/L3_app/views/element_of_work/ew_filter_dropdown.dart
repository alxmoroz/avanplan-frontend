// Copyright (c) 2022. Alexandr Moroz

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/ew_filter_presenter.dart';

class EWFilterDropdown extends StatelessWidget {
  List<DropdownMenuItem<EWFilter>> get ddItems => ewFilterController.ewFilterKeys
      .map(
        (item) => DropdownMenuItem<EWFilter>(
          value: item,
          child: NormalText(ewFilterText(item)),
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
          child: DropdownButtonFormField2<EWFilter>(
            decoration: const InputDecoration(isDense: true, border: InputBorder.none),
            items: ddItems,
            value: ewFilterController.ewFilter,
            icon: downCaretIcon(context),
            onChanged: (type) => ewFilterController.setFilter(type),
            dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(onePadding)),
            isExpanded: true,
          ),
        ),
        SizedBox(width: onePadding),
      ],
    );
  }
}
