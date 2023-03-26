// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/role.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons_workspace.dart';
import '../../components/material_wrapper.dart';
import '../../components/mt_button.dart';
import '../../components/mt_constrained.dart';
import '../../components/mt_limit_badge.dart';
import '../../components/mt_menu_shape.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/role_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import '../tariff/tariff_select_view.dart';
import 'member_add_view.dart';

class MemberAddMenu extends StatelessWidget {
  const MemberAddMenu(this.task);
  final Task task;

  Workspace get _ws => mainController.selectedWS!;
  String get _title => loc.member_new_title;

  @override
  Widget build(BuildContext context) {
    return task.plMembersAdd
        ? material(MTConstrained(Padding(
            padding: const EdgeInsets.symmetric(horizontal: P),
            child: PopupMenuButton<Role>(
              child: MTMenuShape(icon: const MemberAddIcon(), title: _title),
              itemBuilder: (_) => [for (final r in task.allowedRoles) PopupMenuItem<Role>(value: r, child: NormalText(r.localize))],
              onSelected: (r) async => await memberAddDialog(task, r),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
            ),
          )))
        : MTLimitBadge(
            child: MTButton.outlined(
              leading: const MemberAddIcon(),
              titleText: _title,
              color: backgroundColor,
              margin: const EdgeInsets.only(left: P2 + P_2, right: P),
              constrained: true,
              onTap: () => changeTariff(_ws, reason: loc.tariff_change_limit_users_reason_title),
            ),
            showBadge: true,
          );
  }
}
