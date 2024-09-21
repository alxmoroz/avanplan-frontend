// Copyright (c) 2022. Alexandr Moroz

import '../entities/attachment.dart';
import 'abs_api_repo.dart';

abstract class AbstractAttachmentsRepo extends AbstractApiRepo<Attachment, Attachment> {
  Future<Attachment?> upload(
    int wsId,
    int taskId,
    int noteId,
    Stream<List<int>> Function() data,
    int length,
    String filename,
    DateTime lastModified,
  ) =>
      throw UnimplementedError();
}
