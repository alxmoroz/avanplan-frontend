// Copyright (c) 2023. Alexandr Moroz

import '../task/controllers/task_controller.dart';
import 'abstract_quiz_controller.dart';

abstract class AbstractTaskQuizController extends AbstractQuizController {
  AbstractTaskQuizController(this.taskController);
  late final TaskController taskController;
}
