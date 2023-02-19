// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:share_plus/share_plus.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_text_field.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'invitation_controller.dart';

class InvitationPane extends StatelessWidget {
  const InvitationPane(this.controller);
  final InvitationController controller;

  bool get _hasUrl => controller.invitationUrl.isNotEmpty;

  Widget _tfForCode(BuildContext context, String code) {
    final ta = controller.tfAnnoForCode(code);
    final isDate = code.endsWith('Date');

    return ta.noText
        ? MTTextField.noText(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: isDate ? () => controller.selectDate(context) : null,
            prefixIcon: isDate ? const CalendarIcon() : null,
          )
        : MTTextField(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
            keyboardType: code == 'activationsCount' ? TextInputType.number : null,
          );
  }

  Future _shareInvitation(BuildContext context) async {
    if (!_hasUrl) {
      await controller.createInvitation();
    }

    if (!isWeb) {
      final box = context.findRenderObject() as RenderBox?;
      await Share.shareWithResult(
        controller.invitationUrl,
        subject: controller.invitationSubject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  bool get _canShare => _hasUrl || controller.validated;

  Widget _copyButton(BuildContext context) => MTButton(
        middle: Row(
          children: [
            Container(height: P * 3, width: 1, color: borderColor.resolve(context)),
            const SizedBox(width: P),
            const CopyIcon(),
            const SizedBox(width: P),
          ],
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: NormalText(loc.copied_notification_title, align: TextAlign.center),
            backgroundColor: darkBackgroundColor.resolve(context),
            duration: const Duration(milliseconds: 1234),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => Column(
          children: [
            for (final code in ['activationsCount', 'activeDate']) _tfForCode(context, code),
            isWeb && _hasUrl
                ? MTTextField.noText(
                    label: loc.invitation_url_label,
                    controller: TextEditingController(text: controller.invitationUrl),
                    suffixIcon: _copyButton(context),
                  )
                : MTButton.outlined(
                    leading: ShareIcon(size: P2, color: _canShare ? mainColor : lightGreyColor),
                    constrained: false,
                    titleText: loc.invitation_share_action_title,
                    onTap: _canShare ? () => _shareInvitation(context) : null,
                    padding: const EdgeInsets.symmetric(horizontal: P2),
                    margin: const EdgeInsets.only(top: P2),
                  ),
          ],
        ),
      );
}
