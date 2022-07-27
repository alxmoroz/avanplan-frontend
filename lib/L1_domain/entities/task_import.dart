// Copyright (c) 2022. Alexandr Moroz

// TODO: можно было отнаследоваться от Smartable. Но там обязательно id...
//  Возможно,если разнести Importable и PKGetable как на бэке,то получится упростить немного

class TaskImport {
  TaskImport({
    required this.remoteCode,
    required this.title,
    required this.description,
    this.selected = true,
  });

  final String remoteCode;
  final String title;
  final String description;
  final bool selected;

  TaskImport copyWithSelected(bool _selected) => TaskImport(
        remoteCode: remoteCode,
        title: title,
        description: description,
        selected: _selected,
      );
}
