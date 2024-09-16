// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/ws_member.dart';
import 'assignee_filter_controller.dart';
import 'view_settings_controller.dart';

Future showTaskAssigneeFilterDialog(TaskViewSettingsController vsController) async {
  final afc = TaskViewAssigneeFilterController(vsController);
  await showMTDialog<void>(_TaskAssigneeFilterDialog(afc), maxWidth: SCR_XS_WIDTH);
}

class _TaskAssigneeFilterDialog extends StatelessWidget {
  const _TaskAssigneeFilterDialog(this._afController);
  final TaskViewAssigneeFilterController _afController;

  Task get _task => _afController.task;

  Future _save(BuildContext context) async {
    _afController.save();
    Navigator.of(context).pop();
  }

  Widget _item(BuildContext context, index) {
    final member = _afController.activeMembers[index];
    return MTCheckBoxTile(
      leading: member.icon(P3, borderColor: mainColor),
      title: '$member',
      value: _afController.checks[index] == true,
      onChanged: (bool? value) => _afController.check(index, value),
      bottomDivider: index < _task.activeMembers.length - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          pageTitle: '${loc.view_filter_title} - ${loc.task_assignee_label}',
          parentPageTitle: _task.title,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            MTShadowed(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _afController.checks.length,
                itemBuilder: _item,
              ),
            ),
          ],
        ),
        bottomBar: MTAppBar(
          isBottom: true,
          inDialog: true,
          padding: EdgeInsets.only(top: P2, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
          middle: MTButton.main(
            titleText: loc.action_apply_title,
            onTap: () => _save(context),
          ),
        ),
      ),
    );
  }
}
