// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/project_status.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/project_statuses_controller.dart';
import 'project_status_edit_controller.dart';

Future projectStatusEditDialog(
  ProjectStatus status,
  ProjectStatusesController statusesController,
) async =>
    await showMTDialog<void>(_ProjectStatusEditDialog(status, statusesController));

class _ProjectStatusEditDialog extends StatefulWidget {
  const _ProjectStatusEditDialog(this._status, this._statusesController);
  final ProjectStatus _status;
  final ProjectStatusesController _statusesController;

  @override
  State<StatefulWidget> createState() => _ProjectStatusEditDialogState();
}

class _ProjectStatusEditDialogState extends State<_ProjectStatusEditDialog> {
  late final ProjectStatusEditController _controller;

  ProjectStatus get _status => _controller.status;

  @override
  void initState() {
    _controller = ProjectStatusEditController(widget._statusesController);
    _controller.init(widget._status);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _used => _controller.usedInTasks;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          title: loc.status_title,
          trailing: !_used && !_controller.loading
              ? MTButton.icon(
                  const DeleteIcon(),
                  onTap: () => _controller.delete(context),
                  padding: const EdgeInsets.all(P2),
                )
              : null,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            MTField(
              _controller.fData(StatusFCode.title.index),
              value: MTTextField(
                controller: _controller.teController(StatusFCode.title.index),
                autofocus: true,
                margin: EdgeInsets.zero,
                maxLines: 2,
                decoration: InputDecoration(
                  errorText: _controller.codeError,
                  errorStyle: const SmallText('', color: dangerColor, maxLines: 1).style(context),
                  errorMaxLines: 1,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: _controller.codePlaceholder,
                  hintStyle: const H1('', color: f3Color, maxLines: 2).style(context),
                ),
                style: const H1('', maxLines: 2).style(context),
                onChanged: _controller.editTitle,
              ),
              padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(bottom: P),
              color: b2Color,
            ),
            const SizedBox(height: P),
            MTField(
              _controller.fData(StatusFCode.closed.index),
              value: MTListTile(
                leading: DoneIcon(true, color: _used ? f3Color : f2Color, size: P6),
                middle: BaseText.medium(loc.state_closed, maxLines: 1, color: _used ? f3Color : null),
                trailing: CupertinoSwitch(
                  value: _status.closed,
                  activeColor: mainColor,
                  thumbColor: b3Color,
                  trackColor: b2Color,
                  onChanged: _used ? null : (_) => _controller.toggleClosed(),
                ),
                padding: EdgeInsets.zero,
                bottomDivider: false,
                loading: _controller.loading,
              ),
            ),
            if (_used)
              BaseText.f2(
                loc.status_used_in_tasks_label(_controller.tasksWithStatusCount),
                align: TextAlign.center,
                maxLines: 1,
                padding: const EdgeInsets.symmetric(horizontal: P3, vertical: P),
              ),
          ],
        ),
      ),
    );
  }
}
