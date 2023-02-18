// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import 'member_edit_view.dart';

class MemberViewArgs {
  MemberViewArgs(this.member, this.task);
  final Member member;
  final Task task;
}

class MemberView extends StatelessWidget {
  const MemberView(this.args);
  final MemberViewArgs args;

  static String get routeName => '/member';

  Member get member => args.member;
  Task get task => args.task;

  Future _editMember() async {
    await memberEditDialog(task, member);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, title: loc.member_title),
        body: SafeArea(
            top: false,
            child: ListView(
              children: [
                const SizedBox(height: P),
                member.icon(P3),
                const SizedBox(height: P_2),
                H3('$member', align: TextAlign.center),
                const SizedBox(height: P_2),
                NormalText(member.email, align: TextAlign.center),
                if (member.roles.isNotEmpty) ...[
                  const SizedBox(height: P2),
                  H4('${loc.roles_in_task_prefix}$task', align: TextAlign.center),
                  MTListTile(
                    middle: NormalText(member.rolesStr),
                    trailing: task.canEditMembers ? MTButton.icon(const EditIcon(), () => _editMember()) : null,
                  )
                ]
              ],
            )),
      ),
    );
  }
}
