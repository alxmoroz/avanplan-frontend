// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../presenters/ws_member.dart';
import '../../../app/services.dart';
import '../../controllers/task_settings_controller.dart';

Future showTaskAssigneeFilterDialog(TaskSettingsController tsc) async => await showMTDialog(_TaskAssigneeFilterDialog(tsc), maxWidth: SCR_XS_WIDTH);

class _TaskAssigneeFilterDialog extends StatelessWidget {
  const _TaskAssigneeFilterDialog(this._tsc);
  final TaskSettingsController _tsc;

  Future _save(BuildContext context) async {
    _tsc.saveAssigneeFilter();
    Navigator.of(context).pop();
  }

  Widget _item(BuildContext context, index) {
    final member = _tsc.activeMembers[index];
    return MTCheckBoxTile(
      leading: member.icon(P3, borderColor: mainColor),
      title: '$member',
      value: _tsc.membersChecks[index] == true,
      onChanged: (bool? value) => _tsc.checkMember(index, value),
      bottomDivider: index < _tsc.activeMembers.length - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(pageTitle: '${loc.view_filter_title} - ${loc.task_assignee_label}', parentPageTitle: _tsc.task.title),
        body: ListView(
          shrinkWrap: true,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: _tsc.membersChecks.length,
              itemBuilder: _item,
            ),
          ],
        ),
        bottomBar: MTBottomBar(middle: MTButton.main(titleText: loc.action_apply_title, onTap: () => _save(context))),
      ),
    );
  }
}
