// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../extra/router.dart';
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
  void afterFinish() {}

  void back() {
    _back();
    router.pop();
  }

  Future next() async {
    await beforeNext();
    if (_lastStep) {
      finish();
    } else {
      _next();
      await afterNext();
    }
  }

  void finish() {
    _finish();
    afterFinish();
  }
}

abstract class _QuizControllerBase with Store {
  Iterable<QuizStep> get steps => [];
  int get stepsCount => steps.length;

  @observable
  bool active = true;

  @observable
  int stepIndex = 0;

  @computed
  QuizStep get step => steps.elementAt(stepIndex);

  @computed
  bool get _lastStep => stepIndex == stepsCount - 1;

  @computed
  String get stepTitle => step.title;

  @computed
  String get nextBtnTitle => active ? (_lastStep ? loc.lets_go_action_title : step.nextButtonTitle) : '';

  @action
  void _back() {
    if (stepIndex == 0) {
      active = false;
    }
  }

  @action
  void _next() => stepIndex++;

  @action
  void _finish() {
    active = false;
    stepIndex = 0;
  }
}
