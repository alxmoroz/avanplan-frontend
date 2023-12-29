// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/button.dart';
import '../../../../components/circular_progress.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import 'invitation_controller.dart';

Future invitationDialog(Task task) async => await showMTDialog<void>(InvitationDialog(task));

class InvitationDialog extends StatelessWidget {
  InvitationDialog(Task _task) : _controller = InvitationController(_task);
  final InvitationController _controller;

  Widget _copyButton(BuildContext context) => MTButton(
      middle: Row(
        children: [
          Container(height: P * 24, width: 1, color: b2Color.resolve(context)),
          const SizedBox(width: P2),
          const CopyIcon(),
          const SizedBox(width: P2),
        ],
      ),
      onTap: () => _controller.copy(context));

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
          topBar: MTAppBar(
            showCloseButton: true,
            color: b2Color,
            middle: _controller.task.subPageTitle('${loc.invitation_share_subject_prefix}${loc.app_title}'),
          ),
          body: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              if (_controller.roleSelected)
                BaseText.medium(
                  _controller.role!.title,
                  align: TextAlign.center,
                  padding: const EdgeInsets.only(top: P2, bottom: P),
                ),
              if (_controller.hasUrl && isWeb) ...[
                MTTextField.noText(
                  label: loc.invitation_share_label,
                  maxLines: 6,
                  controller: TextEditingController(text: _controller.invitationText),
                  suffixIcon: _copyButton(context),
                )
              ] else if (!_controller.roleSelected) ...[
                BaseText(
                  loc.role_select_action_title,
                  align: TextAlign.center,
                  maxLines: 1,
                  padding: const EdgeInsets.only(top: P, bottom: P),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controller.roles.length,
                    itemBuilder: (_, index) {
                      final r = _controller.roles.elementAt(index);
                      return MTListTile(
                        middle: BaseText.medium(r.title, maxLines: 1),
                        subtitle: SmallText(r.description, maxLines: 1),
                        trailing: const MemberAddIcon(),
                        bottomDivider: index < _controller.roles.length - 1,
                        onTap: () => _controller.inviteRole(r, context),
                      );
                    }),
              ] else
                const Center(child: MTCircularProgress(color: mainColor, unbound: true)),
            ],
          )),
    );
  }
}
