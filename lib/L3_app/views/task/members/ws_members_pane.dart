// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/member.dart';
import '../../../components/constants.dart';
import '../../../components/mt_dropdown.dart';
import '../../../components/mt_text_field.dart';
import '../../../extra/services.dart';
import 'tmr_controller.dart';

class WSMembersPane extends StatelessWidget {
  const WSMembersPane(this.controller);
  final TMRController controller;

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => Column(
          children: [
            if (controller.allowedMembers.isNotEmpty)
              MTDropdown<Member>(
                onChanged: (m) => controller.selectMember(m),
                value: controller.member,
                items: controller.allowedMembers,
                margin: tfPadding,
                label: loc.task_assignee_placeholder,
              ),
            const SizedBox(height: P2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (controller.member != null) ...[
                  // MTButton.outlined(
                  //   constrained: false,
                  //   titleText: loc.save_action_title,
                  //   onTap: controller.validated ? () => controller.save(context, task: task, parent: parent) : null,
                  //   padding: const EdgeInsets.symmetric(horizontal: P2),
                  // ),
                  // if (isNew)
                  //   MTButton.outlined(
                  //     constrained: false,
                  //     titleText: loc.save_and_repeat_action_title,
                  //     onTap: controller.validated ? () => controller.save(context, task: task, parent: parent, proceed: true) : null,
                  //     margin: const EdgeInsets.only(left: P),
                  //     padding: const EdgeInsets.symmetric(horizontal: P),
                  //   ),
                ]
              ],
            ),
          ],
        ),
      );
}
