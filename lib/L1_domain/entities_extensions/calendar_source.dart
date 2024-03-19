// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/calendar_source.dart';

CalendarSourceType cSourceFromStr(String? strType) =>
    CalendarSourceType.values.firstWhereOrNull((s) => s.name == strType) ?? CalendarSourceType.UNKNOWN;
