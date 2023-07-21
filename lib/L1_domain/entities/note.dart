// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Note extends RPersistable {
  Note({
    required super.id,
    required this.text,
    required this.authorId,
    this.createdOn,
    this.updatedOn,
  });

  final String text;
  final int? authorId;
  final DateTime? createdOn;
  final DateTime? updatedOn;
}
