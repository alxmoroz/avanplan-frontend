// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';

extension SourceTypeMapper on SourceTypeGet {
  SourceType get type => SourceType(
        id: id,
        title: title,
      );
}
