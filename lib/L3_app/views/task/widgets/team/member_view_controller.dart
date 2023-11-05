// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../extra/services.dart';
import 'member_edit_dialog.dart';

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

  @computed
  int? get memberId => member?.id;

  @action
  Future editMember(BuildContext context) async {
    final members = await memberEditDialog(task, member!);
    if (members != null) {
      task.members = members;
      final deleted = !members.map((m) => m.id).contains(memberId);
      if (deleted) {
        if (task.assigneeId == memberId) {
          task.assigneeId = null;
        }
        if (task.authorId == memberId) {
          task.authorId = null;
        }
        Navigator.of(context).pop();
      } else {
        member = members.firstWhere((m) => m.id == memberId);
      }

      tasksMainController.refreshTasks();
    }
  }
}
