// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/ws_member.dart';
import '../../../../../L1_domain/entities/ws_member_contact.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/alert_dialog.dart';
import '../../../../components/avatar.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/linkify/linkify.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/select_dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../presenters/contact.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/ws_member.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../../views/_base/loader_screen.dart';
import '../../../../views/person/contacts_dialog.dart';
import '../../../app/services.dart';
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
      parentPageTitle: '$_projectMember',
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
        MTDialogAction(title: loc.action_disconnect_title, type: MTButtonType.danger, result: true),
        MTDialogAction(title: loc.action_no_dont_disconnect_title, result: false),
      ],
    );

    if (confirm == true) {
      if (context.mounted) Navigator.of(context).pop();
      await _pmc.unlinkRole();
    }
  }

  void _showAllContacts() {
    showPersonContactsDialog('$_projectMember', [
      ..._pmc.emails,
      ..._pmc.phones,
      ..._pmc.urls,
      ..._pmc.others,
    ]);
  }

  Widget _contacts(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: P3),
        for (WSMemberContact? contact in [_pmc.firstPhone, _pmc.firstEmail, _pmc.firstUrl])
          if (contact != null)
            MTButton.icon(
              contact.icon,
              margin: const EdgeInsets.only(right: P3),
              onTap: () => contact.tap(context),
            ),
        if (_pmc.needShowAll)
          _pmc.onlyOthers
              ? MTButton(
                  titleText: loc.person_contacts_title,
                  trailing: kIsWeb ? null : const ChevronIcon(),
                  padding: const EdgeInsets.symmetric(horizontal: P2),
                  margin: const EdgeInsets.only(right: P3),
                  onTap: _showAllContacts,
                )
              : MTButton.icon(
                  const MenuIcon(size: P5),
                  margin: const EdgeInsets.only(right: P3),
                  onTap: _showAllContacts,
                ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _pmc.loading || _projectMember == null
          ? LoaderScreen(_pmc, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(pageTitle: loc.project_member_title, parentPageTitle: _project.title),
              body: ListView(
                shrinkWrap: true,
                children: [
                  /// Аватарка
                  const SizedBox(height: P3),
                  _projectMember!.icon(MAX_AVATAR_RADIUS),

                  /// Имя, фамилия
                  const SizedBox(height: P3),
                  MTLinkify('$_projectMember', style: const H2('').style(context), textAlign: TextAlign.center),

                  /// Способы связи
                  if (_pmc.contacts.isNotEmpty) ...[
                    const SizedBox(height: P2),
                    _contacts(context),
                  ],

                  /// Ответственный в задачах в проекте
                  MTListTile(
                    color: b3Color,
                    margin: const EdgeInsets.only(top: P3),
                    leading: const PersonIcon(),
                    middle: BaseText(loc.task_assignee_placeholder, maxLines: 1),
                    trailing: kIsWeb ? null : const ChevronIcon(),
                    dividerIndent: P5 + DEF_TAPPABLE_ICON_SIZE,
                    bottomDivider: true,
                    onTap: () => _assigneeFilterSet(context),
                  ),

                  /// Права в проекте
                  MTListTile(
                    color: b3Color,
                    leading: const PrivacyIcon(),
                    middle: BaseText(loc.role_title, maxLines: 1),
                    subtitle: SmallText(_projectMember!.rolesTitles, maxLines: 1),
                    trailing: _project.canEditTeam ? const EditIcon() : null,
                    loading: _project.loading,
                    onTap: _project.canEditTeam ? () => _editRoles(context) : null,
                  ),

                  /// Отключение от проекта
                  MTListTile(
                    color: b3Color,
                    middle: BaseText(loc.project_member_unlink_action_title, color: dangerColor, align: TextAlign.center, maxLines: 1),
                    margin: const EdgeInsets.only(top: P6),
                    onTap: () => _unlinkMember(context),
                  ),
                ],
              ),
              forceBottomPadding: !isBigScreen(context),
            ),
    );
  }
}
