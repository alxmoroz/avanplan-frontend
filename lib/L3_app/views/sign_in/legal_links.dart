// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../extra/services.dart';
import '../../presenters/communications_presenter.dart';

class LegalLinks extends StatelessWidget {
  const LegalLinks();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          MTButton(titleText: loc.legal_rules_title, trailing: const LinkOutIcon(), onTap: () => launchUrlString(legalRulesPath)),
          const SizedBox(height: P_2),
          MTButton(titleText: loc.legal_privacy_policy_title, trailing: const LinkOutIcon(), onTap: () => launchUrlString(legalConfidentialPath)),
        ],
      );
}
