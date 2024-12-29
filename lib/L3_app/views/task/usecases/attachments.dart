// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/attachment.dart';
import '../../../../L1_domain/entities/note.dart';
import '../../../../L2_data/services/api.dart';
import '../../app/services.dart';
import '../controllers/attachments_controller.dart';
import '../widgets/attachments/upload_dialog.dart';

extension AttachmentsUC on AttachmentsController {
  Future uploadAttachments(Note note) async {
    if (selectedFiles.isNotEmpty) {
      for (final f in selectedFiles) {
        final attachment = await attachmentsUC.upload(
          task.wsId,
          task.id!,
          note.id!,
          f.openRead,
          await f.length(),
          f.name,
          await f.lastModified(),
        );
        if (attachment != null) {
          task.attachments.add(attachment);
        }
      }
      setFiles([]);
      reload();
    }
  }

  Future download(Attachment attachment) async {
    final urlString = Uri.encodeFull('${openAPI.dio.options.baseUrl}/v1/workspaces/${attachment.wsId}/attachments/download/${attachment.name}');
    if (await canLaunchUrlString(urlString)) {
      await launchUrlString(urlString);
    }
  }

  Future startUpload() async {
    final files = await selectFilesDialog();
    setFiles(files);
  }
}
