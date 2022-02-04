// Copyright (c) 2021. Alexandr Moroz

import '../../../extra/services.dart';
import '../entities/base.dart';
import '../repositories/database_repository.dart';

extension BaseUC on BaseEntity {
  DBRepository? get repo => hStorage.repoForName(classCode);

  Future saveOnDisk() async => await repo?.save(this, model);

  Future deleteFromDisk() async => await repo?.delete(this, model);
}
