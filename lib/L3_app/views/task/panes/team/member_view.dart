// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/navbar.dart';
import '../../../../components/page.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/person.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_available_actions.dart';
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
          child: MTAdaptive(
            child: ListView(
              children: [
                const SizedBox(height: P3),
                member.icon(P10),
                const SizedBox(height: P3),
                H3('$member', align: TextAlign.center),
                BaseText(member.email, align: TextAlign.center),
                if (member.roles.isNotEmpty) ...[
                  MTListSection(loc.role_list_title),
                  MTListTile(
                    middle: BaseText(member.rolesStr),
                    trailing: task.canEditMembers ? const EditIcon() : null,
                    bottomDivider: false,
                    onTap: () => task.canEditMembers ? controller.editMember(context) : null,
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
