// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/note.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../extra/services.dart';

extension NotePresenter on Note {
  bool isMine(Task task) => task.memberForId(authorId)?.userId == accountController.user?.id;
}
