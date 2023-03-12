// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/role.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/icons_workspace.dart';
import '../../components/material_wrapper.dart';
import '../../components/mt_constrained.dart';
import '../../components/mt_menu_shape.dart';
import '../../components/text_widgets.dart';
import '../../presenters/role_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import 'member_add_view.dart';

class MemberAddMenu extends StatelessWidget {
  const MemberAddMenu(this.task, {this.title});

  final Task task;
  final String? title;

  Future _addMember(Role role) async {
    await memberAddDialog(task, role);
  }

  @override
  Widget build(BuildContext context) {
    return material(
      MTConstrained(
        PopupMenuButton<Role>(
          child: MTMenuShape(icon: const MemberAddIcon(), title: title),
          itemBuilder: (_) => [for (final r in task.allowedRoles) PopupMenuItem<Role>(value: r, child: NormalText(r.localize))],
          onSelected: (r) async => await _addMember(r),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
        ),
      ),
    );
  }
}
