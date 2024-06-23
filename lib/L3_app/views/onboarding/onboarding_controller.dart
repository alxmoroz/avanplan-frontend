// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/button.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../quiz/abstract_quiz_controller.dart';

part 'onboarding_controller.g.dart';

enum _StepCode { done, milestone, devices_sync, promo_features, where_we_go }

class OnboardingController extends _OnboardingControllerBase with _$OnboardingController {
  @override
  Future afterNext() async {
    if (isPromoFeaturesStep) await accountController.registerPromoFeaturesViewed();
  }

  @override
  Future finish() async {
    router.pop();
    await accountController.registerOnboardingPassed(stepIndex);
  }
}

abstract class _OnboardingControllerBase extends AbstractQuizController with Store {
  @computed
  bool get isPromoFeaturesStep => step.code == _StepCode.promo_features.name;

  @computed
  bool get isWhereWeGoStep => step.code == _StepCode.where_we_go.name;

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.done.name, '', awaiting: false),
        QuizStep(_StepCode.milestone.name, '', awaiting: false),
        QuizStep(_StepCode.devices_sync.name, '', awaiting: false),
        // показываем шаг с рекламой, если в текущем тарифе есть функции
        if (wsMainController.myWS.hasFeatures)
          QuizStep(
            _StepCode.promo_features.name,
            '',
            awaiting: false,
            nextButtonType: ButtonType.secondary,
            nextButtonTitle: loc.later,
          ),
        // показываем шаг с выбором финального действия для создания проекта или задачи, если нет ни одного проекта или задачи
        if (!tasksMainController.hasAnyTasks)
          QuizStep(
            _StepCode.where_we_go.name,
            '',
            awaiting: false,
          ),
      ];
}
