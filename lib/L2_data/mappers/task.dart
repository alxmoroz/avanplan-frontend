// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_state.dart';
import 'attachment.dart';
import 'feature_set.dart';
import 'member.dart';
import 'note.dart';
import 'project_status.dart';
import 'task_source.dart';

extension TaskMapper on api.TaskGet {
  Task task(int wsId) {
    final ts = taskSource?.taskSource;
    String _title = title.trim();
    if (type != null && type?.toLowerCase() == 'backlog') {
      _title = Intl.message(_title);
    }

    return Task(
      id: id,
      createdOn: createdOn.toLocal(),
      updatedOn: updatedOn.toLocal(),
      title: _title,
      type: type ?? 'TASK',
      description: description?.trim() ?? '',
      startDate: startDate?.toLocal(),
      closedDate: closedDate?.toLocal(),
      dueDate: dueDate?.toLocal(),
      closed: closed ?? false,
      statusId: statusId,
      estimate: estimate,
      notes: notes?.map((n) => n.note(wsId)).toList() ?? [],
      attachments: attachments?.map((a) => a.attachment(wsId)) ?? [],
      authorId: authorId,
      assigneeId: assigneeId,
      members: members?.map((m) => m.member(id)) ?? [],
      projectStatuses: projectStatuses?.map((ps) => ps.projectStatus).toList() ?? [],
      projectFeatureSets: projectFeatureSets?.map((pfs) => pfs.projectFeatureSet) ?? [],
      taskSource: ts,
      parentId: parentId,
      wsId: wsId,
      state: tStateFromStr(state ?? ''),
      velocity: velocity?.toDouble() ?? 0,
      requiredVelocity: requiredVelocity?.toDouble(),
      progress: progress?.toDouble() ?? 0,
      etaDate: etaDate?.toLocal(),
      openedVolume: openedVolume,
      closedVolume: closedVolume,
      closedSubtasksCount: closedSubtasksCount,
    );
  }
}

extension TaskRemoteMapper on api.TaskRemote {
  TaskRemote get taskRemote => TaskRemote(
        title: title,
        type: type ?? 'PROJECT',
        description: description ?? '',
        taskSource: taskSource.taskSourceRemote,
      );
}
