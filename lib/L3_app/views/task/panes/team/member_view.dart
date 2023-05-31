// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_list_tile.dart';
import '../../../../components/mt_page.dart';
import '../../../../components/navbar.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/person_presenter.dart';
import '../../../../presenters/task_level_presenter.dart';
import '../../../../usecases/task_ext_actions.dart';
import 'member_view_controller.dart';

// TODO: параметр "задача" не нужен, т.к. есть инфа об айдишнике задачи в участнике
class MemberViewArgs {
  MemberViewArgs(this.member, this.task);
  final Member member;
  final Task task;
}

class MemberView extends StatefulWidget {
  const MemberView(this.args);
  final MemberViewArgs args;

  static String get routeName => '/member';

  @override
  State<MemberView> createState() => _MemberViewState();
}

class _MemberViewState extends State<MemberView> {
  Task get task => controller.task;
  Member get member => controller.member ?? widget.args.member;

  late final MemberViewController controller;

  @override
  void initState() {
    controller = MemberViewController(widget.args.task, widget.args.member);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, middle: task.subPageTitle(loc.member_title)),
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
                  MTListSection(loc.role_list_title),
                  MTListTile(
                    middle: NormalText(member.rolesStr),
                    trailing: task.canEditMembers ? const EditIcon() : null,
                    bottomBorder: false,
                    onTap: () => task.canEditMembers ? controller.editMember(context) : null,
                  )
                ]
              ],
            )),
      ),
    );
  }
}
