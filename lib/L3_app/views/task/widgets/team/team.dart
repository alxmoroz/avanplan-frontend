// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../presenters/person.dart';
import '../../../../presenters/ws_member.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import 'invitation_button.dart';
import 'member_dialog.dart';
import 'no_members.dart';

class Team extends StatelessWidget {
  const Team(this._controller, {super.key, this.standalone = true});
  final TaskController _controller;
  final bool standalone;

  Task get _task => _controller.task;
  List<WSMember> get _activeMembers => _task.activeMembers;

  static const _iconSize = P8;

  Widget _memberBuilder(BuildContext context, int index) {
    final member = _activeMembers[index];
    return MTListTile(
      leading: member.icon(_iconSize / 2),
      middle: BaseText('$member', maxLines: 1),
      subtitle: SmallText(member.rolesTitles, maxLines: 1),
      trailing: const ChevronIcon(),
      dividerIndent: _iconSize + P5,
      bottomDivider: index < _activeMembers.length - 1 || _task.canInviteMembers,
      onTap: () async => await taskMemberDialog(_controller, member.id!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _activeMembers.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: standalone ? null : const NeverScrollableScrollPhysics(),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: _memberBuilder,
                  itemCount: _activeMembers.length,
                ),
                if (_task.canInviteMembers) InvitationButton(_task, inList: true),
              ],
            )
          : NoMembers(_task),
    );
  }
}
