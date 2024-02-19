// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

class ReleaseNote extends Titleable {
  ReleaseNote({
    required super.id,
    required super.title,
    required super.description,
    required this.version,
  });

  final String version;
}
