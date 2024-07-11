// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_state.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import 'attachment.dart';
import 'member.dart';
import 'note.dart';
import 'project_module.dart';
import 'project_status.dart';
import 'task_source.dart';

extension TaskMapper on api.TaskGet {
  Task task(int wsId) {
    final mappedTask = Task(
      id: id,
      createdOn: createdOn.toLocal(),
      updatedOn: updatedOn.toLocal(),
      title: title.trim(),
      type: type ?? TType.TASK,
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
      members: members?.map((m) => m.wsMember(wsId)) ?? [],
      projectStatuses: projectStatuses?.map((ps) => ps.projectStatus(wsId)).sorted((s1, s2) => s1.position.compareTo(s2.position)) ?? [],
      projectModules: projectModules?.map((pm) => pm.projectModule) ?? [],
      taskSource: taskSource?.taskSource,
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
      notesCountIn: notesCount,
      attachmentsCountIn: attachmentsCount,
      subtasksCountIn: subtasksCount,
    );

    if (mappedTask.isBacklog || mappedTask.isInbox) {
      mappedTask.title = Intl.message(mappedTask.isInbox ? mappedTask.title.toLowerCase() : mappedTask.title);
    }

    return mappedTask;
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
