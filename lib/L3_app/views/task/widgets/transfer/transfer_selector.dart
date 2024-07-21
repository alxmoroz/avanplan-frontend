// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_tree.dart';
import '../../../../views/_base/loader_screen.dart';
import 'transfer_selector_controller.dart';

class TransferSelectorDialog extends StatelessWidget {
  const TransferSelectorDialog(this._controller, this._titleText, this._emptyText, {super.key});
  final TransferSelectorController _controller;
  final String _titleText;
  final String _emptyText;

  static const _AVANPLAN_KEY_OTHER_PROJECTS = '_AVANPLAN_KEY_OTHER_PROJECTS';

  List<MapEntry<String, List<Task>>> get _groups {
    final gt = groupBy<Task, String>(_controller.tasks, (t) => t.isProject ? _AVANPLAN_KEY_OTHER_PROJECTS : t.project.title);
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

  Widget _groupBuilder(BuildContext context, int groupIndex) {
    final group = _groups[groupIndex];
    final tasks = group.value;
    final groupTitle = group.key;
    return Column(
      children: [
        if (_groups.isNotEmpty) MTListGroupTitle(titleText: groupTitle == _AVANPLAN_KEY_OTHER_PROJECTS ? loc.projects_group_other_title : groupTitle),
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
              onTap: () => Navigator.of(context).pop(t),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final empty = _controller.tasks.isEmpty;
      return _controller.loading
          ? LoaderScreen(_controller, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                showCloseButton: true,
                color: b2Color,
                title: empty ? '' : _titleText,
              ),
              body: empty
                  ? ListView(
                      shrinkWrap: true,
                      children: [
                        MTImage(ImageName.no_info.name),
                        H3(_emptyText, align: TextAlign.center, padding: const EdgeInsets.all(P3)),
                        MTButton.secondary(titleText: loc.ok, onTap: () => Navigator.of(context).pop()),
                        if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _groups.length,
                      itemBuilder: _groupBuilder,
                    ),
            );
    });
  }
}
