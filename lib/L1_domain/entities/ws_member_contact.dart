// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

class WSMemberContact extends RPersistable {
  WSMemberContact({
    super.id,
    required this.memberId,
    required this.value,
  });

  final int memberId;
  final String value;
}
