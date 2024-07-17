// Copyright (c) 2024. Alexandr Moroz

import 'attachment.dart';
import 'base_entity.dart';

class Note extends WSBounded implements Comparable {
  Note({
    required super.wsId,
    super.id,
    required this.text,
    required this.taskId,
    this.authorId,
    this.parent,
    this.type,
    super.createdOn,
    super.updatedOn,
  });

  String text;
  final int taskId;

  final int? authorId;
  final Note? parent;
  String? type;

  List<Attachment> attachments = [];

  @override
  int compareTo(other) => other.createdOn!.compareTo(createdOn!);
}
