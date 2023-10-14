// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';

extension TaskAttachments on Task {
  String get attachmentsStr => attachments.map((a) => a.title).take(1).join(', ');
  String get attachmentsCountMoreStr => attachments.length > 1 ? loc.more_count(attachments.length - 1) : '';
}
