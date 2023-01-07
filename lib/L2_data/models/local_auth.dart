// Copyright (c) 2022. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../L1_domain/entities/local_auth.dart';
import '../services/db.dart';
import 'base.dart';

part 'local_auth.g.dart';

@HiveType(typeId: HType.LocalAuth)
class LocalAuthHO extends BaseModel<LocalAuth> {
  @HiveField(3, defaultValue: '')
  String authToken = '';

  @override
  LocalAuth toEntity() => LocalAuth(accessToken: authToken);

  @override
  Future update(LocalAuth entity) async {
    id = entity.id;
    authToken = entity.accessToken;
    await save();
  }
}
