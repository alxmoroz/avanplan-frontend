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

  @HiveField(4)
  DateTime? signinDate;

  @override
  LocalAuth toEntity() => LocalAuth(
        accessToken: authToken,
        signinDate: signinDate,
      );

  @override
  Future update(LocalAuth entity) async {
    id = entity.id;
    authToken = entity.accessToken;
    signinDate = entity.signinDate;
    await save();
  }
}
