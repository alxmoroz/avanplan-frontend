// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../extra/services.dart';

part 'abstract_quiz_controller.g.dart';

class QuizStep {
  QuizStep(this.code, this.title, this.nextButtonTitle);
  final String code;
  final String title;
  final String nextButtonTitle;
}

abstract class AbstractQuizController extends _QuizControllerBase with _$AbstractQuizController {
  Future afterNext() async {}
  Future beforeNext() async {}
  void finish() {}

  Future next() async {
    await beforeNext();
    if (_lastStep) {
      finish();
    } else {
      _next();
      await afterNext();
      _back();
    }
  }
}

abstract class _QuizControllerBase with Store {
  Iterable<QuizStep> get steps => [];
  int get stepsCount => steps.length;

  @observable
  int stepIndex = 0;

  @computed
  QuizStep get step => steps.elementAt(stepIndex);

  @computed
  bool get _lastStep => stepIndex == stepsCount - 1;

  @computed
  String get stepTitle => step.title;

  @computed
  String get nextBtnTitle => (_lastStep ? loc.lets_go_action_title : step.nextButtonTitle);

  @action
  void _back() {
    if (stepIndex > 0) {
      stepIndex--;
    }
  }

  @action
  void _next() => stepIndex++;
}
