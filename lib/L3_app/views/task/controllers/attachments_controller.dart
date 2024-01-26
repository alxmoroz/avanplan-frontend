// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/attachment.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L2_data/services/api.dart';
import '../../../../main.dart';
import '../../../extra/services.dart';
import 'task_controller.dart';

part 'attachments_controller.g.dart';

class AttachmentsController extends _AttachmentsControllerBase with _$AttachmentsController {
  AttachmentsController(TaskController taskController) {
    _taskController = taskController;
    _setAttachments(taskController.task!.attachments);
  }
}

abstract class _AttachmentsControllerBase with Store {
  late final TaskController _taskController;

  Task get task => _taskController.task!;

  @observable
  ObservableList<Attachment> _attachments = ObservableList();

  @action
  void _setAttachments(Iterable<Attachment> attachments) => _attachments = ObservableList.of(attachments);

  @computed
  List<Attachment> get sortedAttachments => _attachments.sorted((a1, a2) => compareNatural(a1.title, a2.title));

  @computed
  String get attachmentsStr => sortedAttachments.map((a) => a.title).take(1).join(', ');
  @computed
  String get attachmentsCountMoreStr => sortedAttachments.length > 1 ? loc.more_count(_attachments.length - 1) : '';

  // Future create() async => await edit(Attachment(text: '', authorId: task.me?.id, taskId: task.id, wsId: task.ws.id!));

  // Future delete(Attachment attachment) async {
  //   await attachment.delete(task);
  //   _setAttachments(task.attachments);
  // }

  Future download(Attachment attachment) async {
    final urlString = Uri.encodeFull('${openAPI.dio.options.baseUrl}/v1/workspaces/${attachment.wsId}/attachments/download/${attachment.name}');
    if (await canLaunchUrlString(urlString)) {
      await launchUrlString(urlString);
    }
    if (sortedAttachments.length < 2) {
      Navigator.of(rootKey.currentContext!).pop();
    }
  }
}
