// Copyright (c) 2024. Alexandr Moroz

import '../../L3_app/usecases/task_tree.dart';
import '../entities/task.dart';

extension TaskCopyExtension on Task {
  Task copyWith({required int? parentId, required int? projectStatusId}) => Task(
        id: id,
        parentId: parentId ?? this.parentId,
        createdOn: createdOn,
        updatedOn: updatedOn,
        title: title,
        type: type,
        description: description,
        startDate: startDate,
        closedDate: closedDate,
        dueDate: dueDate,
        repeat: repeat,
        closed: closed,
        projectStatusId: projectStatusId ?? this.projectStatusId,
        estimate: estimate,
        notes: notes,
        attachments: attachments,
        transactions: transactions,
        income: income,
        expenses: expenses,
        authorId: authorId,
        assigneeId: assigneeId,
        members: members,
        projectStatuses: projectStatuses,
        projectModules: projectModules,
        taskSource: taskSource,
        wsId: wsId,
        state: state,
        velocity: velocity,
        requiredVelocity: requiredVelocity,
        progress: progress,
        etaDate: etaDate,
        openedVolume: openedVolume,
        closedVolume: closedVolume,
        notesCountIn: notesCount,
        attachmentsCountIn: attachmentsCount,
        subtasksCountIn: subtasksCount,
        closedSubtasksCountIn: closedSubtasksCount,
      );
}
