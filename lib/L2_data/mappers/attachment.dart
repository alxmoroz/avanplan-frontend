// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/attachment.dart';

extension AttachmentMapper on AttachmentGet {
  Attachment attachment(int wsId) => Attachment(
        id: id,
        title: title,
        description: description ?? '',
        wsId: wsId,
        name: name,
        type: type ?? '',
        bytes: bytes ?? 0,
        updatedOn: updatedOn.toLocal(),
      );
}
