// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../_base/loader_screen.dart';
import 'tasks_selector_controller.dart';

class TasksSelectorDialog extends StatelessWidget {
  const TasksSelectorDialog(
    this._tsc,
    this._pageTitle,
    this._emptyText, {
    this.parentPageTitle,
    super.key,
  });
  final TasksSelectorController _tsc;
  final String _pageTitle;
  final String? parentPageTitle;
  final String _emptyText;

  Widget _groupBuilder(BuildContext context, int groupIndex) {
    final group = _tsc.groups[groupIndex];
    final tasks = group.value;
    final groupTitle = group.key;
    return Column(
      children: [
        if (groupTitle.isNotEmpty)
          MTListGroupTitle(
            titleText: groupTitle == AVANPLAN_KEY_OTHER_PROJECTS ? loc.projects_group_other_title : groupTitle,
          ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (_, index) {
            final t = tasks[index];
            return MTListTile(
              leading: t.isInbox ? const InboxIcon(color: f2Color, size: P5) : null,
              titleText: t.title,
              subtitle: t.description.isNotEmpty ? SmallText(t.description, maxLines: 1) : null,
              trailing: const ChevronIcon(),
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
      final empty = _tsc.tasks.isEmpty;
      return _tsc.loading
          ? LoaderScreen(_tsc, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(
                pageTitle: empty ? '' : _pageTitle,
                parentPageTitle: empty ? '' : parentPageTitle,
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
                      itemCount: _tsc.groups.length,
                      itemBuilder: _groupBuilder,
                    ),
            );
    });
  }
}
