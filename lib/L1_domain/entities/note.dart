// Copyright (c) 2022. Alexandr Moroz

import 'attachment.dart';
import 'base_entity.dart';

class Note extends WSBounded {
  Note({
    super.id,
    required this.text,
    required this.authorId,
    required this.taskId,
    required super.wsId,
    this.parent,
    this.type,
    this.createdOn,
    this.updatedOn,
  });

  String text;
  final int? authorId;
  final int taskId;
  final Note? parent;
  String? type;
  final DateTime? createdOn;
  final DateTime? updatedOn;

  List<Attachment> attachments = [];
}
