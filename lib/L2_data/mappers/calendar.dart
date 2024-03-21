// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/calendar.dart';

extension CalendarMapper on CalendarGet {
  Calendar get calendar => Calendar(
        id: id,
        title: title,
        description: description ?? '',
      );
}
