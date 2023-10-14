// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/attachment.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import 'task_controller.dart';

part 'attachments_controller.g.dart';

class AttachmentsController extends _AttachmentsControllerBase with _$AttachmentsController {
  AttachmentsController(TaskController _taskController) {
    taskController = _taskController;
    _setAttachments(_taskController.task.attachments);
  }
}

abstract class _AttachmentsControllerBase with Store {
  late final TaskController taskController;

  Task get task => taskController.task;

  @observable
  ObservableList<Attachment> _attachments = ObservableList();

  @action
  void _setAttachments(Iterable<Attachment> attachments) => _attachments = ObservableList.of(attachments);

  @computed
  List<Attachment> get sortedAttachments => _attachments.sorted((a1, a2) => compareNatural(a1.title, a2.title));

  @computed
  String get attachmentsStr => sortedAttachments.map((a) => a.title).take(1).join(', ');
  @computed
  String get attachmentsCountMoreStr => sortedAttachments.length > 1 ? loc.more_count(sortedAttachments.length - 1) : '';

  // Future create() async => await edit(Attachment(text: '', authorId: task.me?.id, taskId: task.id, wsId: task.ws.id!));

  // Future delete(Attachment attachment) async {
  //   await attachment.delete(task);
  //   _setAttachments(task.attachments);
  // }
}
