// Copyright (c) 2023. Alexandr Moroz

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/select_dialog.dart';
import '../../../../components/text.dart';

Future<Task?> selectTask(List<Task> taskList, String title) async => await showMTSelectDialog<Task>(
      taskList,
      null,
      title,
      subtitleBuilder: (_, t) => t.description.isNotEmpty ? SmallText(t.description, maxLines: 1) : null,
    );
