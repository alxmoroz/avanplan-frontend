// Copyright (c) 2022. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../../L1_domain/entities/base.dart';
import '../../../L1_domain/repositories/abstract_db_repo.dart';

abstract class BaseModel<E extends BaseEntity> extends HiveObject implements AbstractDBModel<E> {
  @HiveField(0, defaultValue: '')
  String id = '';

  @HiveField(1)
  String title = '';

  @HiveField(2)
  String description = '';
}
