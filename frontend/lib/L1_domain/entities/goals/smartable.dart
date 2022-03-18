// Copyright (c) 2022. Alexandr Moroz

import '../base_entity.dart';

abstract class Smartable extends Titleable {
  Smartable({
    required int id,
    required String title,
    required this.description,
    required this.createdOn,
    required this.updatedOn,
    required this.dueDate,
  }) : super(id: id, title: title);

  final String description;
  final DateTime createdOn;
  final DateTime updatedOn;
  final DateTime? dueDate;
}
