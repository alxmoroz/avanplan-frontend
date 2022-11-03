// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../extra/services.dart';
import '../../presenters/communications_presenter.dart';

class SignInTermsLinks extends StatelessWidget {
  const SignInTermsLinks();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          MTButton(titleText: loc.privacy_policy_title, trailing: const LinkOutIcon(), onTap: () => launchUrlString('$docsUrlPath/privacy')),
        ],
      );
}
