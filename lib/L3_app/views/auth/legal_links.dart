// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L2_data/repositories/communications_repo.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../extra/services.dart';

class LegalLinks extends StatelessWidget {
  const LegalLinks();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          MTButton(
            middle: SmallText(loc.legal_rules_title, color: mainColor),
            trailing: const LinkOutIcon(),
            onTap: () => launchUrlString(legalRulesPath),
          ),
          const SizedBox(height: P_2),
          MTButton(
            middle: SmallText(loc.legal_privacy_policy_title, color: mainColor),
            trailing: const LinkOutIcon(),
            onTap: () => launchUrlString(legalConfidentialPath),
          ),
        ],
      );
}
