// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/button.dart';
import '../../navigation/router.dart';
import '../app/services.dart';
import '../my_account/usecases/onboarding.dart';
import '../quiz/abstract_quiz_controller.dart';

part 'onboarding_controller.g.dart';

enum OnboardingStepCode { done, milestone, devices_sync, promo_features, where_we_go }

class OnboardingController extends _OnboardingControllerBase with _$OnboardingController {
  OnboardingController({TaskDescriptor? hostProjectIn}) {
    hostProject = hostProjectIn;
  }

  @override
  Future afterNext() async {
    if (isPromoFeaturesStep) await myAccountController.registerPromoFeaturesViewed();
  }

  @override
  Future finish() async {
    router.pop(step.code);
    await myAccountController.registerOnboardingPassed(step.code);
  }
}

abstract class _OnboardingControllerBase extends AbstractQuizController with Store {
  late final TaskDescriptor? hostProject;

  @computed
  bool get isPromoFeaturesStep => step.code == OnboardingStepCode.promo_features.name;

  @computed
  bool get isWhereWeGoStep => step.code == OnboardingStepCode.where_we_go.name;

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(OnboardingStepCode.done.name, '', awaiting: false),
        QuizStep(OnboardingStepCode.milestone.name, '', awaiting: false),
        QuizStep(OnboardingStepCode.devices_sync.name, '', awaiting: false),
        // показываем шаг с рекламой, если в текущем тарифе есть функции
        if (wsMainController.myWS.hasFeatures)
          QuizStep(
            OnboardingStepCode.promo_features.name,
            '',
            awaiting: false,
            nextButtonType: MTButtonType.secondary,
            nextButtonTitle: loc.later,
          ),
        // показываем шаг с выбором финального действия для создания проекта или задачи
        // а также для перехода к проекту, куда пригласили
        QuizStep(OnboardingStepCode.where_we_go.name, '', awaiting: false),
      ];
}
