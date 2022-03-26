// Copyright (c) 2022. Alexandr Moroz

abstract class LocalPersistable {
  LocalPersistable({required this.id});
  String id;
}

abstract class RPersistable {
  RPersistable({
    required this.id,
  });

  final int id;
  bool deleted = false;
}

abstract class Titleable extends RPersistable {
  Titleable({
    required int id,
    required this.title,
  }) : super(id: id);

  final String title;
}

abstract class Orderable extends Titleable {
  Orderable({
    required int id,
    required String title,
    required this.order,
  }) : super(id: id, title: title);

  final int order;
}

abstract class Statusable extends Titleable {
  Statusable({
    required int id,
    required String title,
    required this.closed,
  }) : super(id: id, title: title);

  final bool closed;
}
