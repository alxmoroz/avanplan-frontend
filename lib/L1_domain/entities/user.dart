// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class User extends Emailable {
  User({
    required int id,
    required String email,
    required this.fullname,
  }) : super(id: id, email: email);

  final String fullname;

  @override
  String toString() => '${fullname.isNotEmpty ? fullname : email}';
}
