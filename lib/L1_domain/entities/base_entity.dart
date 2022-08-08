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
  Emailable({int? id, required this.email}) : super(id: id);

  final String email;
}

abstract class Titleable extends RPersistable {
  Titleable({int? id, required this.title}) : super(id: id);

  final String title;

  @override
  String toString() => title;
}

abstract class Orderable extends Titleable {
  Orderable({
    int? id,
    required String title,
    required this.order,
  }) : super(id: id, title: title);

  final int order;
}

abstract class Statusable extends Titleable {
  Statusable({
    int? id,
    required String title,
    required this.closed,
  }) : super(id: id, title: title);

  final bool closed;
}
