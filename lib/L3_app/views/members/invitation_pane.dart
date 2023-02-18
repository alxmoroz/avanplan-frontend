// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_text_field.dart';
import '../../extra/services.dart';
import 'tmr_controller.dart';

class InvitationPane extends StatelessWidget {
  const InvitationPane(this.controller);
  final TMRController controller;

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
    if (controller.invitationUrl.isEmpty) {
      await controller.createInvitation();
    }

    final box = context.findRenderObject() as RenderBox?;
    await Share.shareWithResult(
      controller.invitationUrl,
      subject: controller.invitationSubject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  bool get _canShare => controller.invitationUrl.isNotEmpty || controller.validated;

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => Column(
          children: [
            for (final code in ['activationsCount', 'activeDate']) _tfForCode(context, code),
            const SizedBox(height: P2),
            MTButton.outlined(
              leading: ShareIcon(size: P2, color: _canShare ? mainColor : lightGreyColor),
              constrained: false,
              titleText: loc.invitation_share_action_title,
              onTap: _canShare ? () => _shareInvitation(context) : null,
              padding: const EdgeInsets.symmetric(horizontal: P2),
            ),
          ],
        ),
      );
}
