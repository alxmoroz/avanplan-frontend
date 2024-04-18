// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:file_selector/file_selector.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/attachment.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L2_data/services/api.dart';
import '../../../extra/services.dart';
import '../widgets/attachments/upload_dialog.dart';
import 'task_controller.dart';

part 'attachments_controller.g.dart';

class AttachmentsController extends _AttachmentsControllerBase with _$AttachmentsController {
  AttachmentsController(TaskController taskController) {
    _taskController = taskController;
    reload();
  }
}

abstract class _AttachmentsControllerBase with Store {
  late final TaskController _taskController;

  Task get task => _taskController.task!;

  @observable
  ObservableList<Attachment> _attachments = ObservableList();

  @action
  void reload() => _attachments = ObservableList.of(task.attachments);

  @computed
  List<Attachment> get sortedAttachments => _attachments.sorted((a1, a2) => a1.compareTo(a2));

  static const _visibleFileNames = 1;

  @computed
  String get attachmentsStr => sortedAttachments.map((a) => a.title).take(_visibleFileNames).join(', ');
  @computed
  String get attachmentsCountMoreStr => sortedAttachments.length > _visibleFileNames ? loc.more_count(_attachments.length - _visibleFileNames) : '';

  /// выбранные файлы для прикрепления к комменту или задаче
  @observable
  List<XFile> selectedFiles = [];
  @action
  void setFiles(List<XFile> files) => selectedFiles = files;

  @computed
  String get selectedFilesStr => selectedFiles.map((f) => f.name).take(_visibleFileNames).join(', ');
  @computed
  String get selectedFilesCountMoreStr => selectedFiles.length > _visibleFileNames ? loc.more_count(selectedFiles.length - _visibleFileNames) : '';

  Future selectFiles() async {
    final files = await selectFilesDialog();
    setFiles(files);
  }

  Future download(Attachment attachment) async {
    final urlString = Uri.encodeFull('${openAPI.dio.options.baseUrl}/v1/workspaces/${attachment.wsId}/attachments/download/${attachment.name}');
    if (await canLaunchUrlString(urlString)) {
      await launchUrlString(urlString);
    }
  }
}
