// Copyright (c) 2024. Alexandr Moroz

import 'abs_contact.dart';

class WSMemberContact extends AbstractContact {
  WSMemberContact({
    super.id,
    required super.value,
    super.description,
    required this.memberId,
  });

  final int memberId;
}
