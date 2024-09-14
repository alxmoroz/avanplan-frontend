// Copyright (c) 2024. Alexandr Moroz

enum TasksViewMode { LIST, BOARD }

class TaskViewSettings {
  TaskViewSettings({this.viewMode = TasksViewMode.BOARD});
  final TasksViewMode viewMode;

  bool get showBoard => viewMode == TasksViewMode.BOARD;

  TaskViewSettings copyWith({
    TasksViewMode? viewMode,
  }) =>
      TaskViewSettings(
        viewMode: viewMode ?? this.viewMode,
      );
}
