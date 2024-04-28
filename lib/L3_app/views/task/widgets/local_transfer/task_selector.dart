// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/dialog.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_tree.dart';

Future<Task?> selectTask(List<Task> taskList, String title) async => await showMTDialog<Task>(_TaskSelectDialog(taskList, title));

class _TaskSelectDialog extends StatelessWidget {
  const _TaskSelectDialog(this._taskList, this._titleText);
  final List<Task> _taskList;
  final String _titleText;

  static const _AVANPLAN_KEY_OTHER_PROJECTS = '_AVANPLAN_KEY_OTHER_PROJECTS';

  List<MapEntry<String, List<Task>>> get _groups {
    final gt = groupBy<Task, String>(_taskList, (t) => t.isProject ? _AVANPLAN_KEY_OTHER_PROJECTS : t.project.title);
    return gt.entries.sorted((g1, g2) {
      final t1 = g1.key;
      final t2 = g2.key;
      int res = 0;

      if (t1 == _AVANPLAN_KEY_OTHER_PROJECTS) {
        res = 1;
      } else if (t2 == _AVANPLAN_KEY_OTHER_PROJECTS) {
        res = -1;
      }

      if (res == 0) {
        res = compareNatural(g1.key, g2.key);
      }

      return res;
    });
  }

  bool get _showGroupTitles => _groups.length > 1;

  Widget _groupBuilder(BuildContext context, int groupIndex) {
    final group = _groups[groupIndex];
    final tasks = group.value;
    final groupTitle = group.key;
    return Column(
      children: [
        if (_showGroupTitles) MTListGroupTitle(titleText: groupTitle == _AVANPLAN_KEY_OTHER_PROJECTS ? loc.projects_group_other_title : groupTitle),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (_, index) {
            final t = tasks[index];
            return MTListTile(
              titleText: t.title,
              subtitle: t.description.isNotEmpty ? SmallText(t.description, maxLines: 1) : null,
              bottomDivider: index < tasks.length - 1,
              onTap: () => router.pop(t),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(
        showCloseButton: true,
        color: b2Color,
        title: _titleText,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _groups.length,
        itemBuilder: _groupBuilder,
      ),
    );
  }
}
