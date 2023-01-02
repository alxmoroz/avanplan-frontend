// Copyright (c) 2022. Alexandr Moroz

abstract class LocalPersistable {
  LocalPersistable({required this.id});

  String id;
}

abstract class RPersistable {
  RPersistable({this.id});

  final int? id;
  bool deleted = false;
}

abstract class Emailable extends RPersistable {
  Emailable({super.id, required this.email});

  final String email;
}

abstract class Codable extends RPersistable {
  Codable({super.id, required this.code});

  final String code;

  @override
  String toString() => code;
}

abstract class Titleable extends RPersistable {
  Titleable({super.id, required this.title});

  final String title;

  @override
  String toString() => title;
}

abstract class Orderable extends Codable {
  Orderable({
    super.id,
    required super.code,
    required this.order,
  });

  final int order;
}

abstract class Statusable extends Codable {
  Statusable({
    super.id,
    required super.code,
    required this.closed,
  });

  bool closed;
}
