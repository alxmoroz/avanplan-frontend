// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import 'errors.dart';

abstract class LocalPersistable {
  LocalPersistable({required this.id});

  String id;
}

abstract class RPersistable {
  RPersistable({this.id});

  int? id;
  // TODO: убрать этот механизм (см. как в задачах сделано)
  bool removed = false;

  MTError? error;
  bool? loading = false;

  bool get isNew => id == null;
}

abstract class WSBounded extends RPersistable {
  WSBounded({super.id, required this.wsId});

  final int wsId;
}

abstract class Codable extends RPersistable {
  Codable({super.id, required this.code});

  String code;

  @override
  String toString() => code;
}

abstract class Titleable extends RPersistable implements Comparable {
  Titleable({super.id, required this.title, this.description = ''});

  String title;
  String description;

  @override
  String toString() => title;

  @override
  int compareTo(t2) => compareNatural(title, t2.title);
}
