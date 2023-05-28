// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L2_data/repositories/communications_repo.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/communications_presenter.dart';
import 'registration_controller.dart';

Future registrationDialog() async {
  return await showModalBottomSheet<void>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(RegistrationForm()),
  );
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  late final RegistrationController controller;

  @override
  void initState() {
    controller = RegistrationController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code) {
    final isPassword = code == 'password';
    final isEmail = code == 'email';
    return MTTextField(
      controller: controller.teControllers[code],
      label: controller.tfAnnoForCode(code).label,
      error: controller.tfAnnoForCode(code).errorText,
      obscureText: isPassword && controller.showPassword == false,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
      suffixIcon: isPassword ? MTButton.icon(EyeIcon(open: !controller.showPassword), controller.toggleShowPassword) : null,
      maxLines: 1,
      capitalization: TextCapitalization.none,
    );
  }

  @override
  Widget build(BuildContext context) => MTPage(
        navBar: navBar(
          context,
          title: loc.auth_register_title,
          bgColor: backgroundColor,
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: SCR_S_WIDTH),
              child: LayoutBuilder(
                builder: (_, size) => Observer(
                  builder: (_) => controller.requestCompleted
                      ? ListView(
                          shrinkWrap: true,
                          children: [
                            H3(loc.auth_register_completed_title, align: TextAlign.center),
                            const SizedBox(height: P2),
                            H4(
                              loc.auth_register_completed_description(controller.tfAnnoForCode('email').text),
                              maxLines: 7,
                              align: TextAlign.center,
                            ),
                            const SizedBox(height: P2),
                            SmallText(loc.auth_register_troubleshooting_hint, align: TextAlign.center),
                            MTButton(
                              middle: SmallText(loc.contact_us_title.toLowerCase(), color: mainColor),
                              onTap: () => sendMail(loc.contact_us_mail_subject, appTitle, accountController.user?.id),
                            ),
                            MTButton.main(
                              margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
                              titleColor: greyColor,
                              titleText: loc.ok,
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(height: P2),
                          ],
                        )
                      : ListView(
                          shrinkWrap: true,
                          children: [
                            appIcon(size: size.maxHeight / 4),
                            textFieldForCode('name'),
                            textFieldForCode('email'),
                            textFieldForCode('password'),
                            MTButton.main(
                              margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
                              titleText: loc.auth_register_action_title,
                              onTap: controller.validated ? () => controller.createRequest(context) : null,
                            ),
                            const SizedBox(height: P2),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      );
}
