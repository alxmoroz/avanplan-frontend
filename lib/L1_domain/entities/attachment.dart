// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Attachment extends Titleable {
  Attachment({
    super.id,
    required super.title,
    super.description,
    required this.wsId,
    required this.noteId,
    required this.name,
    required this.type,
    required this.bytes,
  });

  final int wsId;
  final int? noteId;
  final String name;
  final String type;
  final int bytes;
}
