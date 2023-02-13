// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';

part 'task_team_controller.g.dart';

enum MemberSourceTabKey { workspace, external }

class TaskTeamController extends _TaskTeamControllerBase with _$TaskTeamController {
  TaskTeamController(Task _task) {
    task = _task;
  }
}

abstract class _TaskTeamControllerBase with Store {
  late final Task task;

  @computed
  Iterable<MemberSourceTabKey> get tabKeys {
    return [
      MemberSourceTabKey.workspace,
      MemberSourceTabKey.external,
    ];
  }

  @observable
  MemberSourceTabKey? _tabKey;

  @action
  void selectTab(MemberSourceTabKey? tk) => _tabKey = tk;

  @computed
  MemberSourceTabKey get tabKey => (tabKeys.contains(_tabKey) ? _tabKey : null) ?? (tabKeys.isNotEmpty ? tabKeys.first : MemberSourceTabKey.external);

  /// роутер

  Future addMember() async {
    print('addMember');
    // final newMemberResult = await addMemberDialog();

    // if (newMemberResult != null) {
    //   final newMember = newMemberResult.member;
    //   task.members.add(newMember);
    //   if (newMemberResult.proceed == true) {
    //     if (task.isProject || task.isWorkspace) {
    //       await mainController.showTask(newMember.id);
    //     } else {
    //       await addMember();
    //     }
    //   }
    // }
  }
}
