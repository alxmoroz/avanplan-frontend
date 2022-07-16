// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Status extends Statusable {
  Status({
    required int id,
    required String title,
    required bool closed,
    required this.workspaceId,
  }) : super(id: id, title: title, closed: closed);

  final int workspaceId;
}
