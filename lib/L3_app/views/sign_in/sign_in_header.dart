// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader(this.size);

  final BoxConstraints size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        H1(loc.app_title, align: TextAlign.center, padding: const EdgeInsets.symmetric(vertical: P2)),
        appIcon(size: size.maxHeight / 4),
        const SizedBox(height: P2),
        H4(loc.auth_sign_in_title, align: TextAlign.center, color: greyColor),
        const SizedBox(height: P2),
      ],
    );
  }
}
