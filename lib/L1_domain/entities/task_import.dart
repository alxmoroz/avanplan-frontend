// Copyright (c) 2022. Alexandr Moroz

class TaskImport {
  TaskImport({
    required this.code,
    required this.title,
    required this.description,
    this.selected = true,
  });

  final String code;
  final String title;
  final String description;
  final bool selected;

  TaskImport copyWithSelected(bool _selected) => TaskImport(
        code: code,
        title: title,
        description: description,
        selected: _selected,
      );
}
