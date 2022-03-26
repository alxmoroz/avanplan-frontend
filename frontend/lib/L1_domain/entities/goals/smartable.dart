// Copyright (c) 2022. Alexandr Moroz

import '../base_entity.dart';

abstract class Smartable extends Statusable {
  Smartable({
    required int id,
    required String title,
    required bool closed,
    required this.description,
    required this.createdOn,
    required this.updatedOn,
    required this.dueDate,
    required this.parentId,
  }) : super(id: id, title: title, closed: closed);

  final String description;
  final DateTime createdOn;
  final DateTime updatedOn;
  final DateTime? dueDate;
  final int? parentId;
}
