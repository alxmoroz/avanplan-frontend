// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class Contract extends RPersistable {
  Contract({
    required super.id,
    required this.createdOn,
  });

  final DateTime createdOn;
}
