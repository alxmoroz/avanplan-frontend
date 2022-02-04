// Copyright (c) 2021. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../../L1_domain/entities/base.dart';
import '../../../L1_domain/repositories/database_repository.dart';

abstract class EntityMapper<E extends BaseEntity> {
  Future fromEntity(E entity);

  dynamic toEntity(dynamic params);
}

abstract class BaseModel extends HiveObject implements EntityMapper, DBModel {
  @HiveField(100, defaultValue: '')
  String id = '';
}

abstract class TitledModel extends BaseModel {
  @HiveField(0)
  String title = '';

  @HiveField(1)
  String description = '';

  @override
  String toString() => title;
}
