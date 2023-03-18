// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/material_wrapper.dart';
import '../../components/mt_menu_shape.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../views/source/source_edit_view.dart';

class SourceAddMenu extends StatelessWidget {
  const SourceAddMenu({this.title, this.onSelected, this.margin});

  final EdgeInsets? margin;
  final String? title;
  final PopupMenuItemSelected<String>? onSelected;

  @override
  Widget build(BuildContext context) {
    return material(
      Padding(
        padding: margin ?? EdgeInsets.zero,
        child: PopupMenuButton<String>(
          child: MTMenuShape(icon: const PlusIcon(), title: title),
          itemBuilder: (_) => [for (final st in refsController.sourceTypes) PopupMenuItem<String>(value: st, child: iconTitleForSourceType(st))],
          onSelected: onSelected ?? (st) => addSource(sType: st),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
        ),
      ),
    );
  }
}
