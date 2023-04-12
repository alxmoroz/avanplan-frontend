// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../extra/services.dart';
import 'member_edit_view.dart';

part 'member_view_controller.g.dart';

class MemberViewController extends _MemberViewControllerBase with _$MemberViewController {
  MemberViewController(Task _task, Member _member) {
    task = _task;
    member = _member;
  }
}

abstract class _MemberViewControllerBase with Store {
  late Task task;

  @observable
  Member? member;

  Future editMember(BuildContext context) async {
    final members = await memberEditDialog(task, member!);
    if (members != null) {
      task.members = members.toList();
      mainController.updateRootTask();

      try {
        member = members.firstWhere((m) => m.id == member?.id);
      } catch (_) {
        Navigator.of(context).pop();
      }
    }
  }
}
