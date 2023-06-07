// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/role.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons_workspace.dart';
import '../../../../components/material_wrapper.dart';
import '../../../../components/mt_button.dart';
import '../../../../components/mt_constrained.dart';
import '../../../../components/mt_limit_badge.dart';
import '../../../../components/mt_menu_shape.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/role_presenter.dart';
import '../../../../usecases/task_ext_actions.dart';
import '../../../../usecases/ws_ext_actions.dart';
import '../../../tariff/tariff_select_view.dart';
import 'member_add_view.dart';

class MemberAddMenu extends StatelessWidget {
  const MemberAddMenu(this.task);
  final Task task;

  String get _title => loc.invitation_create_title;

  @override
  Widget build(BuildContext context) {
    return MTAdaptive.S(
      task.ws.plUsers
          ? material(
              PopupMenuButton<Role>(
                child: MTMenuShape(icon: const MemberAddIcon(color: lightBackgroundColor), title: _title),
                itemBuilder: (_) => [for (final r in task.ws.roles) PopupMenuItem<Role>(value: r, child: NormalText(r.localize))],
                onSelected: (r) async => await memberAddDialog(task, r),
                padding: EdgeInsets.zero,
                surfaceTintColor: lightBackgroundColor.resolve(context),
                color: lightBackgroundColor.resolve(context),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
              ),
            )
          : MTLimitBadge(
              child: MTButton.main(
                leading: const MemberAddIcon(color: lightBackgroundColor),
                titleText: _title,
                constrained: false,
                onTap: () => changeTariff(task.ws, reason: loc.tariff_change_limit_users_reason_title),
              ),
              showBadge: true,
            ),
    );
  }
}
