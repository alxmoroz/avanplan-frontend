// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/project_status.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../app/services.dart';
import '../../controllers/project_statuses_controller.dart';
import 'project_status_edit_controller.dart';

Future projectStatusEditDialog(ProjectStatus status, ProjectStatusesController statusesController) async =>
    await showMTDialog(_ProjectStatusEditDialog(status, statusesController));

class _ProjectStatusEditDialog extends StatefulWidget {
  const _ProjectStatusEditDialog(this._status, this._statusesController);
  final ProjectStatus _status;
  final ProjectStatusesController _statusesController;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_ProjectStatusEditDialog> {
  late final ProjectStatusEditController _psec;

  ProjectStatus get _status => _psec.status;

  @override
  void initState() {
    _psec = ProjectStatusEditController(widget._statusesController);
    _psec.init(widget._status);
    super.initState();
  }

  @override
  void dispose() {
    _psec.dispose();
    super.dispose();
  }

  bool get _used => _psec.usedInTasks;
  static const _dividerIndent = P5 + DEF_TAPPABLE_ICON_SIZE;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(pageTitle: loc.status_title),
        body: ListView(
          shrinkWrap: true,
          children: [
            MTField(
              _psec.fData(StatusFCode.title.index),
              value: MTTextField(
                controller: _psec.teController(StatusFCode.title.index),
                autofocus: true,
                margin: EdgeInsets.zero,
                maxLines: 2,
                decoration: InputDecoration(
                  errorText: _psec.codeError,
                  errorStyle: const SmallText('', color: dangerColor, maxLines: 1).style(context),
                  errorMaxLines: 1,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: _psec.codePlaceholder,
                  hintStyle: const H1('', color: f3Color, maxLines: 2).style(context),
                ),
                style: const H1('', maxLines: 2).style(context),
                onChanged: _psec.editTitle,
              ),
              padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(bottom: P),
              color: b2Color,
            ),
            if (_psec.canMoveLeft)
              MTListTile(
                leading: const MoveLeftIcon(),
                middle: BaseText.medium(loc.status_move_left_action_title, maxLines: 1, color: mainColor),
                subtitle: SmallText('${_psec.leftStatus}', maxLines: 1),
                bottomDivider: _psec.canMoveRight || !_used,
                dividerIndent: _dividerIndent,
                loading: _psec.fData(StatusFCode.position.index).loading,
                onTap: _psec.moveLeft,
              ),
            if (_psec.canMoveRight)
              MTListTile(
                leading: const MoveRightIcon(),
                middle: BaseText.medium(loc.status_move_right_action_title, maxLines: 1, color: mainColor),
                subtitle: SmallText('${_psec.rightStatus}', maxLines: 1),
                bottomDivider: !_used,
                dividerIndent: _dividerIndent,
                loading: _psec.fData(StatusFCode.position.index).loading,
                onTap: _psec.moveRight,
              ),
            if (_used)
              BaseText.f2(
                loc.status_used_in_tasks_label(_psec.tasksWithStatusCount),
                maxLines: 1,
                padding: const EdgeInsets.symmetric(horizontal: P3, vertical: P2),
              ),
            MTListTile(
              leading: DoneIcon(true, color: _used ? f3Color : mainColor, size: DEF_TAPPABLE_ICON_SIZE),
              middle: BaseText.medium(
                loc.status_means_closed_title,
                maxLines: 1,
                color: _used ? f3Color : null,
              ),
              trailing: CupertinoSwitch(
                value: _status.closed,
                activeTrackColor: mainColor,
                thumbColor: b3Color,
                inactiveTrackColor: b1Color,
                onChanged: _used ? null : (_) => _psec.toggleClosed(),
              ),
              bottomDivider: true,
              dividerIndent: _dividerIndent,
              loading: _psec.loading || _psec.fData(StatusFCode.closed.index).loading,
              onTap: _used ? null : _psec.toggleClosed,
            ),
            MTListTile(
              leading: DeleteIcon(size: DEF_TAPPABLE_ICON_SIZE, color: _used ? f3Color : dangerColor),
              middle: BaseText.medium(loc.action_delete_title, maxLines: 1, color: _used ? f3Color : dangerColor),
              bottomDivider: false,
              onTap: _used ? null : () => _psec.delete(context),
            ),
          ],
        ),
        hasKBInput: true,
      ),
    );
  }
}
