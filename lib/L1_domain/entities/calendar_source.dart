// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

enum CalendarSourceType {
  GOOGLE,
  UNKNOWN,
}

class CalendarSource extends RPersistable {
  CalendarSource({
    super.id,
    required this.email,
    required this.type,
  });

  final String email;
  final CalendarSourceType type;
}
