// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/role.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/material_wrapper.dart';
import '../../components/mt_menu_plus_shape.dart';
import '../../components/text_widgets.dart';
import '../../presenters/role_presenter.dart';
import 'member_edit_view.dart';
import 'tmr_controller.dart';

class MemberAddMenu extends StatelessWidget {
  const MemberAddMenu(this.controller, {this.title, this.margin});

  final TMRController controller;
  final EdgeInsets? margin;
  final String? title;

  Future _addMember(Role role) async {
    controller.selectRole(role);
    await editTMRDialog(controller);
  }

  @override
  Widget build(BuildContext context) {
    return material(
      Padding(
        padding: margin ?? EdgeInsets.zero,
        child: PopupMenuButton<Role>(
          child: MTMenuShape(icon: const MemberAddIcon(), title: title),
          itemBuilder: (_) => [for (final r in controller.allowedRoles) PopupMenuItem<Role>(value: r, child: NormalText(r.localize))],
          onSelected: (r) async => await _addMember(r),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
        ),
      ),
    );
  }
}
