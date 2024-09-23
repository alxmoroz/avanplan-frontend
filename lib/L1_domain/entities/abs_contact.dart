//  Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

abstract class AbstractContact extends RPersistable {
  AbstractContact({
    super.id,
    required this.value,
  });

  final String value;

  @override
  String toString() => value;
}
