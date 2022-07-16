// Copyright (c) 2022. Alexandr Moroz

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/ew_filter_presenter.dart';

class EWFilterDropdown extends StatelessWidget {
  List<DropdownMenuItem<TaskFilter>> get ddItems => tasksFilterController.taskFilterKeys
      .map(
        (item) => DropdownMenuItem<TaskFilter>(
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
          child: DropdownButtonFormField2<TaskFilter>(
            decoration: const InputDecoration(isDense: true, border: InputBorder.none),
            items: ddItems,
            value: tasksFilterController.tasksFilter,
            icon: downCaretIcon(context),
            onChanged: (type) => tasksFilterController.setFilter(type),
            dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(onePadding)),
            isExpanded: true,
          ),
        ),
        SizedBox(width: onePadding),
      ],
    );
  }
}
