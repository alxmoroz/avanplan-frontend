// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/appbar.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/page.dart';
import '../../../../components/text.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/person.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_actions.dart';
import 'member_view_controller.dart';

class MemberViewArgs {
  MemberViewArgs(this.member, this.task);
  final Member member;
  final Task task;
}

class MemberViewRouter extends MTRouter {
  static const _prefix = '/projects';
  static const _suffix = 'members';

  @override
  RegExp get pathRe => RegExp('^$_prefix/(\\d+)/(\\d+)/$_suffix/(\\d+)\$');
  RegExpMatch? get _firstMatch => pathRe.firstMatch(rs!.uri.path);
  int get _wsId => int.parse(_firstMatch?.group(1) ?? '-1');
  int get _taskId => int.parse(_firstMatch?.group(2) ?? '-1');
  int get _memberId => int.parse(_firstMatch?.group(3) ?? '-1');

  Task? get _project => tasksMainController.task(_wsId, _taskId);
  Member? get _member => _project?.memberForId(_memberId);

  MemberViewArgs get _mArgs => rs!.arguments as MemberViewArgs? ?? MemberViewArgs(_member!, _project!);
  // TODO: костыль
  @override
  Widget get page => Observer(builder: (_) => loader.loading ? Container() : MemberView(_mArgs));

  @override
  String get title {
    final mArgs = rs!.arguments as MemberViewArgs?;
    return '${mArgs?.task.viewTitle} | ${mArgs?.member}';
  }

  String _navPath(Task _task, int mId) => '$_prefix/${_task.wsId}/${_task.id}/$_suffix/$mId';

  @override
  Future navigate(BuildContext context, {Object? args}) async => await Navigator.of(context).pushNamed(
        _navPath((args as MemberViewArgs).task, args.member.id!),
        arguments: args,
      );
}

class MemberView extends StatefulWidget {
  const MemberView(this._args);
  final MemberViewArgs _args;

  @override
  State<MemberView> createState() => _MemberViewState();
}

class _MemberViewState extends State<MemberView> {
  Task get task => controller.task;
  Member get member => controller.member ?? widget._args.member;

  late final MemberViewController controller;

  @override
  void initState() {
    controller = MemberViewController(widget._args.task, widget._args.member);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(context, middle: task.subPageTitle(loc.member_title)),
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
                  MTListSection(titleText: loc.role_list_title),
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
