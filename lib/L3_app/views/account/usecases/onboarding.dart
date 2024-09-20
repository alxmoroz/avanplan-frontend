// Copyright (c) 2024. Alexandr Moroz

import '../../../../L1_domain/entities/user_activity.dart';
import '../account_controller.dart';

extension OnboardingUC on AccountController {
  Future registerPromoFeaturesViewed() async {
    await registerActivity(UACode.PROMO_FEATURES_VIEWED);
  }

  Future registerOnboardingPassed(String stepCode) async {
    await registerActivity('${UACode.ONBOARDING_PASSED}_$stepCode');
  }
}
