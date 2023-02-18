// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/role.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/material_wrapper.dart';
import '../../components/mt_menu_plus_shape.dart';
import '../../components/text_widgets.dart';
import '../../presenters/role_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import 'member_add_view.dart';

class MemberAddMenu extends StatelessWidget {
  const MemberAddMenu(this.task, {this.title, this.margin});

  final Task task;
  final EdgeInsets? margin;
  final String? title;

  Future _addMember(Role role) async {
    await memberAddDialog(task, role);
  }

  @override
  Widget build(BuildContext context) {
    return material(
      Padding(
        padding: margin ?? EdgeInsets.zero,
        child: PopupMenuButton<Role>(
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
