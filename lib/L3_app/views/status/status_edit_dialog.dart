// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/status.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/field.dart';
import '../../components/field_data.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/text_field.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import 'status_edit_controller.dart';

Future<Status?> statusEditDialog(Status status) async => await showMTDialog<Status?>(StatusEditDialog(status));

class StatusEditDialog extends StatefulWidget {
  const StatusEditDialog(this.status);
  final Status status;

  @override
  _StatusEditDialogState createState() => _StatusEditDialogState();
}

class _StatusEditDialogState extends State<StatusEditDialog> {
  late final StatusEditController controller;

  Status get _status => controller.status;

  @override
  void initState() {
    controller = StatusEditController(widget.status);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get _used => controller.usedInProjects;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(
          titleText: loc.status_title,
          trailing: !_used
              ? MTButton.icon(
                  const DeleteIcon(),
                  onTap: () => controller.delete(context),
                  padding: const EdgeInsets.all(P2),
                )
              : null,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            MTField(
              controller.fData(StatusFCode.code.index),
              value: MTTextField(
                controller: controller.teController(StatusFCode.code.index),
                autofocus: true,
                margin: EdgeInsets.zero,
                maxLines: 2,
                decoration: InputDecoration(
                  errorText: controller.codeError,
                  errorStyle: const SmallText('', color: dangerColor, maxLines: 1).style(context),
                  errorMaxLines: 1,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: controller.codePlaceholder,
                  hintStyle: const H1('', color: f3Color, maxLines: 2).style(context),
                ),
                style: const H1('', maxLines: 2).style(context),
                onChanged: controller.editCode,
              ),
              padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(bottom: P),
              color: b2Color,
            ),
            const SizedBox(height: P),
            MTField(
              controller.fData(StatusFCode.closed.index),
              value: MTListTile(
                leading: DoneIcon(true, color: _used ? f3Color : f2Color, size: P6),
                middle: BaseText.medium(loc.state_closed, maxLines: 1, color: _used ? f3Color : null),
                trailing: CupertinoSwitch(
                  value: _status.closed,
                  activeColor: mainColor,
                  thumbColor: b3Color,
                  trackColor: b2Color,
                  onChanged: _used ? null : (_) => controller.toggleClosed(),
                ),
                padding: EdgeInsets.zero,
                bottomDivider: false,
              ),
              dividerIndent: P * 11,
              crossAxisAlignment: CrossAxisAlignment.center,
              bottomDivider: true,
            ),
            MTField(
              controller.fData(StatusFCode.allProjects.index),
              value: MTListTile(
                leading: const WSIconPublic(color: f2Color),
                middle: BaseText.medium(loc.status_all_projects_label, maxLines: 1),
                trailing: CupertinoSwitch(
                  value: _status.allProjects,
                  activeColor: mainColor,
                  thumbColor: b3Color,
                  trackColor: b2Color,
                  onChanged: (_) => controller.toggleAllProjects(),
                ),
                padding: EdgeInsets.zero,
                bottomDivider: false,
              ),
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            if (_used)
              MTField(
                MTFieldData(-1, label: loc.status_used_in_projects_label),
                value: Row(children: [
                  Flexible(child: BaseText(controller.projectsWithStatusStr, maxLines: 2)),
                  if (controller.projectsWithStatusCountMoreStr.isNotEmpty) BaseText.f2(controller.projectsWithStatusCountMoreStr, maxLines: 1),
                ]),
                margin: const EdgeInsets.only(top: P3),
              ),
          ],
        ),
      ),
    );
  }
}
