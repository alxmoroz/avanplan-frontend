// Copyright (c) 2021. Alexandr Moroz

import '../repositories/database_repository.dart';

/// Из-за отсутствия ретроспекции. Нужно для идентификации в БД
class ECode {
  static const AppSettings = 'AppSettings';

  String get classCode => throw UnimplementedError;
}

abstract class BaseEntity implements ECode {
  BaseEntity(this.id, {required this.model, this.title = ''});

  String id;
  String title;
  // String description;

  final DBModel? model;

  @override
  String toString() => title;
}
