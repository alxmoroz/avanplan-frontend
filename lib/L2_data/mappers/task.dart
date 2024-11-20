// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan/L2_data/mappers/task_relation.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import 'attachment.dart';
import 'note.dart';
import 'project_module.dart';
import 'project_status.dart';
import 'task_repeat.dart';
import 'task_source.dart';
import 'task_transaction.dart';
import 'ws_member.dart';

extension TaskMapper on api.TaskGet {
  Task task(int wsId) {
    final mappedTask = Task(
      id: id,
      createdOn: createdOn.toLocal(),
      updatedOn: updatedOn.toLocal(),
      title: title.trim(),
      type: TType.fromString(type),
      position: position,
      category: category,
      icon: icon,
      description: description?.trim() ?? '',
      startDate: startDate?.toLocal(),
      closedDate: closedDate?.toLocal(),
      dueDate: dueDate?.toLocal(),
      repeat: repeat?.repeat(wsId),
      repeatsCount: repeatsCount,
      closed: closed ?? false,
      projectStatusId: projectStatusId,
      estimate: estimate,
      relations: relations?.map((r) => r.relation(wsId)).toList() ?? [],
      relationsCount: relationsCount,
      notes: notes?.map((n) => n.note(wsId)).toList() ?? [],
      notesCountIn: notesCount,
      attachments: attachments?.map((a) => a.attachment(wsId)).toList() ?? [],
      attachmentsCountIn: attachmentsCount,
      transactions: transactions?.map((tr) => tr.transaction(wsId)).toList() ?? [],
      income: income ?? 0,
      expenses: expenses ?? 0,
      authorId: authorId,
      assigneeId: assigneeId,
      members: members?.map((m) => m.wsMember(wsId)) ?? [],
      projectStatuses: projectStatuses?.map((ps) => ps.projectStatus(wsId)).sorted((s1, s2) => s1.position.compareTo(s2.position)) ?? [],
      projectModules: projectModules?.map((pm) => pm.projectModule) ?? [],
      taskSource: taskSource?.taskSource,
      parentId: parentId,
      wsId: wsId,
      state: TaskState.fromString(state ?? ''),
      velocity: velocity?.toDouble() ?? 0,
      requiredVelocity: requiredVelocity?.toDouble(),
      progress: progress?.toDouble() ?? 0,
      etaDate: etaDate?.toLocal(),
      openedVolume: openedVolume,
      closedVolume: closedVolume,
      subtasksCountIn: subtasksCount,
      closedSubtasksCountIn: closedSubtasksCount,
      hasSubgroupsIn: hasSubgroups ?? false,
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
        position: position,
        category: category,
        icon: icon,
      );
}

extension TaskRemoteMapper on api.TaskRemote {
  RemoteProject get taskImport => RemoteProject(
        title: title,
        description: description ?? '',
        taskSource: taskSource.taskSourceRemote,
        wsId: -1,
      );
}
