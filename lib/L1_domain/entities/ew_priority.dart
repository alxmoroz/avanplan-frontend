// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class EWPriority extends Orderable {
  EWPriority({
    required int id,
    required int order,
    required String title,
    required this.workspaceId,
  }) : super(id: id, title: title, order: order);

  final int workspaceId;
}
