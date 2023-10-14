// Copyright (c) 2022. Alexandr Moroz

import '../repositories/abs_attachment_repo.dart';

class AttachmentUC {
  AttachmentUC(this.repo);

  final AbstractAttachmentRepo repo;

  // Future<List<int>> download(int wsId, int taskId, int attachmentId) async => await repo.download(wsId, taskId, attachmentId);
}
