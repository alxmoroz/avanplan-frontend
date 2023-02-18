// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/role_presenter.dart';

class MemberViewArgs {
  MemberViewArgs(this.member, this.task);
  final Member member;
  final Task task;
}

class MemberView extends StatelessWidget {
  const MemberView(this.args);
  final MemberViewArgs args;

  Member get member => args.member;
  Task get task => args.task;

  static String get routeName => '/member';

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          title: '${loc.member_title} $task',
          // trailing: MTButton.icon(const DeleteIcon(), () => accountController.delete(context), margin: const EdgeInsets.only(right: P)),
        ),
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
                  H4(loc.roles_title, align: TextAlign.center),
                  for (final r in member.roles)
                    MTListTile(
                      middle: NormalText(localizedRoleCode(r)),
                      // trailing: task.canEditMembers ? MTButton.icon(const EditIcon(), () => print(r)) : null,
                    )
                ]
              ],
            )),
      ),
    );
  }
}
