// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/ws_member.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/alert_dialog.dart';
import '../../../../components/avatar.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/linkify.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/select_dialog.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/ws_member.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/members.dart';
import '../view_settings/view_settings_controller.dart';

Future<String?> projectMemberDialog(TaskController taskController, int memberId) async {
  return await showMTDialog<String?>(_ProjectMemberDialog(taskController, memberId));
}

class _ProjectMemberDialog extends StatelessWidget {
  const _ProjectMemberDialog(this._tc, this._memberId);
  final TaskController _tc;
  final int _memberId;

  Task get _project => _tc.task;
  WSMember? get _member => _project.taskMemberForId(_memberId);

  void _assigneeFilterSet(BuildContext context) {
    TaskViewSettingsController(_tc).setAssigneeFilter(_memberId);
    Navigator.of(context).pop('popToProject');
  }

  Future _editRoles(BuildContext context) async {
    final roles = _project.ws.roles.toList();
    final selectedId = roles.firstWhereOrNull((r) => _member?.roles.contains(r.code) == true)?.id;
    final selectedRole = await showMTSelectDialog(
      roles,
      selectedId,
      loc.role_title,
      parentPageTitle: _member?.viewableName,
      valueBuilder: (_, r) => BaseText(r.title, maxLines: 1),
      subtitleBuilder: (_, r) => r.description.isNotEmpty ? SmallText(r.description, maxLines: 1) : const SizedBox(),
    );
    if (selectedRole != null) {
      await _tc.assignMemberRoles(_memberId, [selectedRole.id!]);
    }
  }

  Future _unlinkMember(BuildContext context) async {
    final confirm = await showMTAlertDialog(
      imageName: ImageName.privacy.name,
      title: loc.project_member_unlink_dialog_title,
      description: loc.project_member_unlink_dialog_description,
      actions: [
        MTDialogAction(title: loc.action_unlink_title, type: ButtonType.danger, result: true),
        MTDialogAction(title: loc.action_no_dont_unlink_title, result: false),
      ],
    );

    if (confirm == true) {
      if (context.mounted) Navigator.of(context).pop();
      await _tc.assignMemberRoles(_memberId, []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          parentPageTitle: _project.title,
          pageTitle: loc.project_member_title,
        ),
        body: _member != null
            ? ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: P3),
                  _member!.icon(MAX_AVATAR_RADIUS),
                  const SizedBox(height: P3),
                  MTLinkify('$_member', style: const H2('').style(context), textAlign: TextAlign.center),
                  // BaseText(_member!.email, align: TextAlign.center, maxLines: 1),

                  /// Ответственный в задачах в проекте
                  MTListTile(
                    margin: const EdgeInsets.only(top: P3),
                    leading: const PersonIcon(),
                    middle: BaseText(loc.task_assignee_placeholder, maxLines: 1),
                    // subtitle: SmallText('', maxLines: 1),
                    trailing: const ChevronIcon(),
                    dividerIndent: P11,
                    onTap: () => _assigneeFilterSet(context),
                  ),

                  /// Права в проекте
                  MTListTile(
                    leading: const PrivacyIcon(),
                    middle: BaseText(loc.role_title, maxLines: 1),
                    subtitle: SmallText(_member!.rolesTitles, maxLines: 1),
                    trailing: _project.canEditMembers ? const EditIcon() : null,
                    bottomDivider: false,
                    loading: _project.loading,
                    onTap: _project.canEditMembers ? () => _editRoles(context) : null,
                  ),

                  /// Отключение от проекта
                  MTListTile(
                    middle: BaseText(loc.project_member_unlink_action_title, color: dangerColor, align: TextAlign.center, maxLines: 1),
                    margin: EdgeInsets.only(top: P6, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
                    bottomDivider: false,
                    onTap: () => _unlinkMember(context),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
