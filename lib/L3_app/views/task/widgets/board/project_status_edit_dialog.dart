// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/project_status.dart';
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

Future projectStatusEditDialog(ProjectStatus status, ProjectStatusesController statusesController) async =>
    await showMTDialog(_ProjectStatusEditDialog(status, statusesController));

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
          pageTitle: loc.status_title,
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
            if (_controller.canMoveLeft)
              MTListTile(
                leading: const MoveLeftIcon(),
                middle: BaseText.medium(loc.status_move_left_action_title, maxLines: 1, color: mainColor),
                subtitle: SmallText('${_controller.leftStatus}', maxLines: 1),
                bottomDivider: _controller.canMoveRight || !_used,
                dividerIndent: P11,
                loading: _controller.fData(StatusFCode.position.index).loading,
                onTap: _controller.moveLeft,
              ),
            if (_controller.canMoveRight)
              MTListTile(
                leading: const MoveRightIcon(),
                middle: BaseText.medium(loc.status_move_right_action_title, maxLines: 1, color: mainColor),
                subtitle: SmallText('${_controller.rightStatus}', maxLines: 1),
                bottomDivider: !_used,
                dividerIndent: P11,
                loading: _controller.fData(StatusFCode.position.index).loading,
                onTap: _controller.moveRight,
              ),
            if (_used)
              BaseText.f2(
                loc.status_used_in_tasks_label(_controller.tasksWithStatusCount),
                maxLines: 1,
                padding: const EdgeInsets.symmetric(horizontal: P3, vertical: P2),
              ),
            MTListTile(
              leading: DoneIcon(true, color: _used ? f3Color : mainColor, size: P6),
              middle: BaseText.medium(
                loc.status_means_closed_title,
                maxLines: 1,
                color: _used ? f3Color : null,
              ),
              trailing: CupertinoSwitch(
                value: _status.closed,
                activeColor: mainColor,
                thumbColor: b3Color,
                trackColor: b1Color,
                onChanged: _used ? null : (_) => _controller.toggleClosed(),
              ),
              bottomDivider: true,
              dividerIndent: P11,
              loading: _controller.loading || _controller.fData(StatusFCode.closed.index).loading,
              onTap: _used ? null : _controller.toggleClosed,
            ),
            MTListTile(
              leading: DeleteIcon(size: P6, color: _used ? f3Color : dangerColor),
              middle: BaseText.medium(loc.action_delete_title, maxLines: 1, color: _used ? f3Color : dangerColor),
              bottomDivider: false,
              onTap: _used ? null : () => _controller.delete(context),
            ),
          ],
        ),
      ),
    );
  }
}
