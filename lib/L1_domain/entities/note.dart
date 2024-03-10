// Copyright (c) 2024. Alexandr Moroz

import 'attachment.dart';
import 'base_entity.dart';

class Note extends WSBounded {
  Note({
    required super.wsId,
    super.id,
    required this.text,
    required this.taskId,
    this.authorId,
    this.parent,
    this.type,
    this.createdOn,
    this.updatedOn,
  });

  String text;
  final int taskId;

  final int? authorId;
  final Note? parent;
  String? type;
  final DateTime? createdOn;
  final DateTime? updatedOn;

  List<Attachment> attachments = [];
}
