// Copyright (c) 2022. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../L1_domain/entities/local_auth.dart';
import '../services/db.dart';
import 'base.dart';

part 'local_auth.g.dart';

@HiveType(typeId: HType.LOCAL_AUTH)
class LocalAuthHO extends BaseModel<LocalAuth> {
  @HiveField(3, defaultValue: '')
  String authToken = '';

  @HiveField(4)
  DateTime? signinDate;

  @override
  LocalAuth toEntity() => LocalAuth(
        accessToken: authToken,
        signinDate: signinDate,
      );

  @override
  Future<LocalAuthHO> update(LocalAuth entity) async {
    authToken = entity.accessToken;
    signinDate = entity.signinDate;
    await save();
    return this;
  }
}
