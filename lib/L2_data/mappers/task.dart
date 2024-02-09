// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
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
    String t = title.trim();
    if (type != null && type?.toLowerCase() == 'backlog') {
      t = Intl.message(t);
    }

    return Task(
      id: id,
      createdOn: createdOn.toLocal(),
      updatedOn: updatedOn.toLocal(),
      title: t,
      type: type ?? 'TASK',
      description: description?.trim() ?? '',
      startDate: startDate?.toLocal(),
      closedDate: closedDate?.toLocal(),
      dueDate: dueDate?.toLocal(),
      closed: closed ?? false,
      projectStatusId: projectStatusId,
      estimate: estimate,
      notes: notes?.map((n) => n.note(wsId)).toList() ?? [],
      attachments: attachments?.map((a) => a.attachment(wsId)).toList() ?? [],
      authorId: authorId,
      assigneeId: assigneeId,
      members: members?.map((m) => m.member(id)) ?? [],
      projectStatuses: projectStatuses?.map((ps) => ps.projectStatus(wsId)).sorted((s1, s2) => s1.position.compareTo(s2.position)) ?? [],
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

extension ProjectMapper on api.ProjectGet {
  Project get project => Project(
        id: id,
        wsId: wsId,
        title: title,
        description: description ?? '',
        category: category,
        icon: icon,
      );
}

extension TaskRemoteMapper on api.TaskRemote {
  ProjectRemote get taskImport => ProjectRemote(
        title: title,
        description: description ?? '',
        taskSource: taskSource.taskSourceRemote,
        wsId: -1,
      );
}
