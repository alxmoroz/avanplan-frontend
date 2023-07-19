// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/mt_select_dialog.dart';
import '../../../../components/text_widgets.dart';

Future<int?> selectTaskDialog(List<Task> taskList, String title) async => await showMTSelectDialog<Task>(
      taskList,
      null,
      title,
      valueBuilder: (_, t) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NormalText(t.title, maxLines: 2),
          if (t.description.isNotEmpty) SmallText(t.description, maxLines: 1),
        ],
      ),
    );
