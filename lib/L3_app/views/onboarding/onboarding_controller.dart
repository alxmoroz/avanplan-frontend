// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/user_activity.dart';
import '../../components/button.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../quiz/abstract_quiz_controller.dart';

part 'onboarding_controller.g.dart';

enum _StepCode { done, milestone, devices_sync, promo_features, start }

class OnboardingController extends _OnboardingControllerBase with _$OnboardingController {
  @override
  Future afterNext() async {
    if (step.code == _StepCode.promo_features.name) await accountController.registerActivity(UACode.PROMO_FEATURES_VIEWED);
  }

  @override
  Future finish() async {
    router.pop();
    _markOnboardingPassed();
  }
}

abstract class _OnboardingControllerBase extends AbstractQuizController with Store {
  Future _markOnboardingPassed() async {
    await accountController.registerActivity('${UACode.ONBOARDING_PASSED}_${stepIndex + 1}');
  }

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.done.name, '', awaiting: false),
        QuizStep(_StepCode.milestone.name, '', awaiting: false),
        QuizStep(_StepCode.devices_sync.name, '', awaiting: false),
        QuizStep(_StepCode.promo_features.name, '', awaiting: false, nextButtonType: ButtonType.secondary, nextButtonTitle: loc.later),
        if (!tasksMainController.hasAnyTasks) QuizStep(_StepCode.start.name, '', awaiting: false),
      ];
}
