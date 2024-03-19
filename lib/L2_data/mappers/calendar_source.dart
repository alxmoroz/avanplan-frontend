// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/calendar_source.dart';
import '../../L1_domain/entities_extensions/calendar_source.dart';

extension CalendarSourceMapper on CalendarSourceGet {
  CalendarSource get source => CalendarSource(
        id: id,
        email: email,
        type: cSourceFromStr(type),
      );
}
