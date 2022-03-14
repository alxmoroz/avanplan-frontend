// Copyright (c) 2022. Alexandr Moroz

// TODO: повторить структуру Л1 с бэка

import '../base_entity.dart';

abstract class Smartable extends Titleable {
  Smartable({
    required int id,
    required String title,
    required this.description,
    required this.dueDate,
    required this.createdOn,
    required this.updatedOn,
  }) : super(id: id, title: title);

  final String description;
  DateTime createdOn;
  DateTime updatedOn;
  final DateTime? dueDate;
}
