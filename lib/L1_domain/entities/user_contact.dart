// Copyright (c) 2024. Alexandr Moroz

import 'abs_contact.dart';

class UserContact extends AbstractContact {
  UserContact({
    super.id,
    required super.value,
    required this.userId,
  });

  final int userId;
}
