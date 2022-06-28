// Copyright (c) 2022. Alexandr Moroz

// TODO: можно было отнаследоваться от Smartable. Но там обязательно id...
//  Возможно,если разнести Importable и PKGetable как на бэке,то получится упростить немного

class GoalImport {
  GoalImport({
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

  GoalImport copyWithSelected(bool _selected) => GoalImport(
        code: code,
        title: title,
        description: description,
        dueDate: dueDate,
        closed: closed,
        selected: _selected,
      );
}
