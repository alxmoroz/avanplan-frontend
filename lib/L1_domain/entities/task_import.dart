// Copyright (c) 2022. Alexandr Moroz

// TODO: можно было отнаследоваться от Smartable. Но там обязательно id...
//  Возможно,если разнести Importable и PKGetable как на бэке,то получится упростить немного

class TaskImport {
  TaskImport({
    required this.code,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.closed,
    this.selected = true,
  });

  final String code;
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool closed;
  final bool selected;

  TaskImport copyWithSelected(bool _selected) => TaskImport(
        code: code,
        title: title,
        description: description,
        dueDate: dueDate,
        closed: closed,
        selected: _selected,
      );
}
