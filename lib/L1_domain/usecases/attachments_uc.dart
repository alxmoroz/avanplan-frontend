// Copyright (c) 2022. Alexandr Moroz

import '../entities/attachment.dart';
import '../repositories/abs_attachments_repo.dart';

class AttachmentsUC {
  AttachmentsUC(this.repo);

  final AbstractAttachmentsRepo repo;

  Future<Attachment?> upload(
    int wsId,
    int taskId,
    int noteId,
    Stream<List<int>> Function() data,
    int length,
    String filename,
    DateTime lastModified,
  ) async =>
      await repo.upload(wsId, taskId, noteId, data, length, filename, lastModified);
}
