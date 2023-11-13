// Copyright (c) 2022. Alexandr Moroz

import '../utils/dates.dart';
import 'base_entity.dart';

class Contract extends RPersistable {
  Contract({
    required super.id,
    required this.createdOn,
  });

  final DateTime createdOn;

  static Contract get dummy => Contract(id: -1, createdOn: now);
}
