// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan/L3_app/presenters/contact.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/abs_contact.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/ws_member.dart';
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
import '../../../../views/_base/loader_screen.dart';
import '../../controllers/task_controller.dart';
import 'project_member_controller.dart';

Future<String?> projectMemberDialog(TaskController tc, int memberId) async {
  final pmc = ProjectMemberController(tc, memberId);
  return await showMTDialog<String?>(_ProjectMemberDialog(pmc));
}

class _ProjectMemberDialog extends StatelessWidget {
  const _ProjectMemberDialog(this._pmc);
  final ProjectMemberController _pmc;

  Task get _project => _pmc.project;
  WSMember? get _projectMember => _pmc.projectMember;

  void _assigneeFilterSet(BuildContext context) {
    _pmc.setAssigneeFilter();
    Navigator.of(context).pop('popToProject');
  }

  Future _editRoles(BuildContext context) async {
    final roles = _project.ws.roles.toList();
    final selectedId = roles.firstWhereOrNull((r) => _projectMember?.roles.contains(r.code) == true)?.id;
    final selectedRole = await showMTSelectDialog(
      roles,
      selectedId,
      loc.role_title,
      parentPageTitle: _projectMember?.viewableName,
      valueBuilder: (_, r) => BaseText(r.title, maxLines: 1),
      subtitleBuilder: (_, r) => r.description.isNotEmpty ? SmallText(r.description, maxLines: 1) : const SizedBox(),
    );
    if (selectedRole != null) {
      await _pmc.assignRole(selectedRole.id!);
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
      await _pmc.unlinkRole();
    }
  }

  Widget _contacts(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: P3),
        for (AbstractContact contact in _pmc.shortlistContacts)
          MTButton.icon(
            contact.icon,
            margin: const EdgeInsets.only(right: P3),
            onTap: () => contact.tap(context),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _pmc.loading
          ? LoaderScreen(_pmc, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                showCloseButton: true,
                color: b2Color,
                parentPageTitle: _project.title,
                pageTitle: loc.project_member_title,
              ),
              body: _projectMember != null
                  ? ListView(
                      shrinkWrap: true,
                      children: [
                        /// Аватарка
                        const SizedBox(height: P3),
                        _projectMember!.icon(MAX_AVATAR_RADIUS),

                        /// Имя, фамилия
                        const SizedBox(height: P3),
                        MTLinkify('$_projectMember', style: const H2('').style(context), textAlign: TextAlign.center),

                        /// Способы связи
                        const SizedBox(height: P2),
                        _contacts(context),

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
                          subtitle: SmallText(_projectMember!.rolesTitles, maxLines: 1),
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
