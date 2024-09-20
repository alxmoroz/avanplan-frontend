// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/person.dart';

extension PersonPresenter on Person {
  String get initials {
    final words = viewableName.split(RegExp(r'\s'));
    return words.map((w) => w.substring(0, 1).toUpperCase()).join('');
  }
}
