//  Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

abstract class AbstractContact extends RPersistable {
  AbstractContact({
    super.id,
    required this.value,
    this.description = '',
  });

  String value;
  String description;

  bool get hasDescription => description.trim().isNotEmpty;

  @override
  String toString() => value;
}
