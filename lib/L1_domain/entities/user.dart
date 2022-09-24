// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class User extends Emailable {
  User({
    required super.id,
    required super.email,
    required this.fullname,
  });

  final String fullname;

  @override
  String toString() => '${fullname.isNotEmpty ? fullname : email}';
}
