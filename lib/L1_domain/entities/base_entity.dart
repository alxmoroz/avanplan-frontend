// Copyright (c) 2022. Alexandr Moroz

import 'errors.dart';
import 'workspace.dart';

abstract class LocalPersistable {
  LocalPersistable({required this.id});

  String id;
}

abstract class RPersistable {
  RPersistable({this.id});

  int? id;
  bool removed = false;

  MTError? error;
  bool? loading = false;

  bool get isNew => id == null;
}

abstract class WSBounded extends RPersistable {
  WSBounded({super.id, required this.ws});

  final Workspace ws;
}

abstract class Codable extends RPersistable {
  Codable({super.id, required this.code});

  final String code;

  @override
  String toString() => code;
}

abstract class Titleable extends RPersistable {
  Titleable({super.id, this.title = '', this.description = ''});

  String title;
  String description;

  @override
  String toString() => title;
}
