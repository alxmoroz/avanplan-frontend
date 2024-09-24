// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/abs_person.dart';

extension PersonPresenter on AbstractPerson {
  String get initials {
    final words = '$this'.split(RegExp(r'\s'));
    return words.map((w) => w.substring(0, 1).toUpperCase()).join('');
  }
}
