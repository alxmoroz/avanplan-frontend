// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/button.dart';
import '../../../../components/circular_progress.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../app/clipboard.dart';
import '../../../app/services.dart';
import 'invitation_controller.dart';

Future invite(Task task) async {
  if (await task.ws.checkBalance(loc.invitation_create_title)) {
    await showMTDialog(_InvitationDialog(InvitationController(task)));
  }
}

class _InvitationDialog extends StatelessWidget {
  const _InvitationDialog(this._controller);
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
        onTap: () => copyToClipboard(context, _controller.invitationText),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(
          pageTitle: '${loc.invitation_share_subject_prefix}${loc.app_title}',
          parentPageTitle: _controller.task.title,
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
                maxLines: 12,
                controller: TextEditingController(text: _controller.invitationText),
                suffixIcon: _copyButton(context),
                margin: const EdgeInsets.all(P3),
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
              const Center(child: MTCircularProgress(unbound: true)),
          ],
        ),
      ),
    );
  }
}
