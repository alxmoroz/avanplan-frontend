// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/services.dart';

part 'quiz_controller.g.dart';

class QuizStep {
  QuizStep(this.code, this.title, this.nextButtonTitle);
  final String code;
  final String title;
  final String nextButtonTitle;
}

abstract class QuizController extends _QuizControllerBase with _$QuizController {
  Future afterBack(BuildContext context) async {}
  Future afterNext(BuildContext context) async {}
  Future beforeNext(BuildContext context) async {}
  Future afterFinish(BuildContext context) async {}

  @action
  Future back(BuildContext context) async {
    _back();
    await afterBack(context);
    Navigator.of(context).pop();
  }

  @action
  Future next(BuildContext context) async {
    await beforeNext(context);
    if (_lastStep) {
      finish(context);
    } else {
      _next();
      await afterNext(context);
      _nextDone();
    }
  }

  @action
  Future finish(BuildContext context) async {
    _finish();
    await afterFinish(context);
  }
}

abstract class _QuizControllerBase with Store {
  @computed
  Iterable<QuizStep> get steps => [];

  @computed
  int get stepsCount => steps.length;

  @observable
  bool active = false;

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
  void _next() {
    stepIndex++;
  }

  @action
  void _nextDone() {
    if (active) {
      stepIndex--;
    }
  }

  @action
  void _finish() {
    active = false;
    stepIndex = 0;
  }
}
