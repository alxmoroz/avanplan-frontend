// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L2_data/services/platform.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_field.dart';
import '../../../../extra/services.dart';
import 'invitation_controller.dart';

class InvitationPane extends StatelessWidget {
  const InvitationPane(this.controller);
  final InvitationController controller;

  bool get _hasUrl => controller.invitationUrl.isNotEmpty;

  bool get _canShare => _hasUrl || controller.validated;

  Widget _copyButton(BuildContext context) => MTButton(
      middle: Row(
        children: [
          Container(height: P * 24, width: 1, color: b2Color.resolve(context)),
          const SizedBox(width: P2),
          const CopyIcon(),
          const SizedBox(width: P2),
        ],
      ),
      onTap: () => controller.copyInvitation(context));

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.tf(InvitationFCode.activationsCount),
            controller.tf(InvitationFCode.expiresOn),
            isWeb && _hasUrl
                ? MTTextField.noText(
                    label: loc.invitation_share_label,
                    maxLines: 6,
                    controller: TextEditingController(text: controller.invitationText),
                    suffixIcon: _copyButton(context),
                  )
                : MTButton.main(
                    leading: ShareIcon(color: _canShare ? mainBtnTitleColor : f2Color),
                    titleText: loc.invitation_share_action_title,
                    onTap: _canShare ? () => controller.shareInvitation(context) : null,
                    margin: const EdgeInsets.only(top: P3),
                  ),
          ],
        ),
      );
}
