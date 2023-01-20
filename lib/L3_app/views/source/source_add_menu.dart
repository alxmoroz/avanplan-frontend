// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/source.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/material_wrapper.dart';
import '../../components/mt_menu_plus_shape.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';

class SourceAddMenu extends StatelessWidget {
  const SourceAddMenu({this.title, this.onSelected, this.margin});

  final EdgeInsets? margin;
  final String? title;
  final PopupMenuItemSelected<SourceType>? onSelected;

  @override
  Widget build(BuildContext context) {
    return material(
      Padding(
        padding: margin ?? EdgeInsets.zero,
        child: PopupMenuButton<SourceType>(
          child: MTMenuShape(icon: const PlusIcon(), title: title),
          itemBuilder: (_) => [for (final st in referencesController.sourceTypes) PopupMenuItem<SourceType>(value: st, child: st.iconTitle)],
          onSelected: onSelected ?? (st) => sourceController.addSource(sType: st),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
        ),
      ),
    );
  }
}
