// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/role.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons_workspace.dart';
import '../../../../components/limit_badge.dart';
import '../../../../components/material_wrapper.dart';
import '../../../../components/menu_shape.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/role.dart';
import '../../../../usecases/ws_available_actions.dart';
import '../../../../usecases/ws_tariff.dart';
import 'member_add_view.dart';

class MemberAddMenu extends StatelessWidget {
  const MemberAddMenu(this.task);
  final Task task;

  String get _title => loc.invitation_create_title;

  @override
  Widget build(BuildContext context) {
    return MTAdaptive.XS(
      child: task.ws.plUsers
          ? material(
              PopupMenuButton<Role>(
                child: MTMenuShape(icon: const MemberAddIcon(color: mainBtnTitleColor), title: _title),
                itemBuilder: (_) => [for (final r in task.ws.roles) PopupMenuItem<Role>(value: r, child: BaseText(r.localized))],
                onSelected: (r) async => await memberAddDialog(task, r),
                padding: EdgeInsets.zero,
                surfaceTintColor: b3Color.resolve(context),
                color: b3Color.resolve(context),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
              ),
            )
          : MTLimitBadge(
              child: MTButton.main(
                leading: const MemberAddIcon(color: mainBtnTitleColor),
                titleText: _title,
                constrained: false,
                onTap: () => task.ws.changeTariff(reason: loc.tariff_change_limit_users_reason_title),
              ),
              showBadge: true,
            ),
    );
  }
}
