// Copyright (c) 2022. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/attachment.dart';
import '../../L1_domain/repositories/abs_attachment_repo.dart';
import '../mappers/attachment.dart';
import '../services/api.dart';

class AttachmentRepo extends AbstractAttachmentRepo {
  o_api.TaskNotesApi get api => openAPI.getTaskNotesApi();

  @override
  Future<Attachment?> upload(
    int wsId,
    int taskId,
    int noteId,
    Stream<List<int>> Function() data,
    int length,
    String filename,
    DateTime lastModified,
  ) async {
    final multipartFile = MultipartFile.fromStream(
      data,
      length,
      filename: filename,
      headers: {
        'last-modified': [lastModified.toIso8601String()]
      },
    );
    final response = await api.uploadAttachment(
      wsId: wsId,
      taskId: taskId,
      noteId: noteId,
      file: multipartFile,
    );

    return response.data?.attachment(wsId);
  }
}
