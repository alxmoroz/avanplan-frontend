// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

class UserContact extends RPersistable {
  UserContact({
    super.id,
    required this.userId,
    required this.value,
  });

  final int userId;
  final String value;
}
