// Copyright (c) 2022. Alexandr Moroz

import 'base_upsert.dart';

class EWUpsert extends StatusableUpsert {
  EWUpsert({
    required int? id,
    required String title,
    required bool closed,
    required this.parentId,
    required this.description,
    required this.dueDate,
    required this.statusId,
  }) : super(id: id, title: title, closed: closed);

  final int? parentId;
  final String description;
  final DateTime? dueDate;
  final int? statusId;
}
