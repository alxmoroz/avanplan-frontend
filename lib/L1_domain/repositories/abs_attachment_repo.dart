// Copyright (c) 2022. Alexandr Moroz

import '../entities/attachment.dart';
import 'abs_api_repo.dart';

abstract class AbstractAttachmentRepo extends AbstractApiRepo<Attachment, Attachment> {
  // Future<List<int>> download(int wsId, String name) => throw UnimplementedError();
}
