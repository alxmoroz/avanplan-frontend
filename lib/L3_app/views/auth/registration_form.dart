// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L2_data/repositories/communications_repo.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/communications_presenter.dart';
import 'registration_controller.dart';

Future showRegistrationDialog(BuildContext context) async {
  return await showModalBottomSheet<void>(
    context: context,
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
  late RegistrationController _controller;

  @override
  void initState() {
    _controller = RegistrationController();
    _controller.initState(tfaList: [
      TFAnnotation('name', label: loc.auth_name_placeholder),
      TFAnnotation('email', label: loc.auth_email_placeholder),
      TFAnnotation('password', label: loc.auth_password_placeholder),
    ]);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code) {
    final isPassword = code == 'password';
    final isEmail = code == 'email';
    return MTTextField(
      controller: _controller.teControllers[code],
      label: _controller.tfAnnoForCode(code).label,
      error: _controller.tfAnnoForCode(code).errorText,
      obscureText: isPassword && _controller.showPassword == false,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
      suffixIcon: isPassword ? MTButton.icon(EyeIcon(open: !_controller.showPassword), _controller.toggleShowPassword) : null,
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
                  builder: (_) => _controller.requestCompleted
                      ? ListView(
                          shrinkWrap: true,
                          children: [
                            H3(loc.auth_register_completed_title, align: TextAlign.center),
                            const SizedBox(height: P2),
                            H4(
                              loc.auth_register_completed_description(_controller.tfAnnoForCode('email').text),
                              maxLines: 7,
                              align: TextAlign.center,
                            ),
                            const SizedBox(height: P2),
                            SmallText(loc.auth_register_troubleshooting_hint, align: TextAlign.center),
                            MTButton(
                              middle: SmallText(loc.contact_us_title.toLowerCase(), color: mainColor),
                              onTap: () => sendMail(loc.contact_us_mail_subject, appTitle, accountController.user?.id),
                            ),
                            MTButton.outlined(
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
                            MTButton.outlined(
                              margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
                              titleText: loc.auth_register_action_title,
                              onTap: _controller.validated ? () => _controller.createRequest(context) : null,
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
