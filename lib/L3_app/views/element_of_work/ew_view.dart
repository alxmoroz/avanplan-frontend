// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import 'ew_dashboard.dart';
import 'ew_view_controller.dart';

class EWView extends StatelessWidget {
  static String get routeName => 'element_of_work';

  EWViewController get _controller => ewViewController;
  ElementOfWork? get _ew => _controller.selectedEW;
  bool get _isGoal => _controller.isGoal;

  String breadcrumbs() {
    const sepStr = ' ⟩ ';
    String _breadcrumbs = '';
    if (!_isGoal) {
      final titles = _controller.navStackTasks.take(_controller.navStackTasks.length - 1).map((pt) => pt.title).toList();
      titles.insert(0, _controller.selectedGoal.title);
      _breadcrumbs = titles.join(sepStr);
    }
    return _breadcrumbs;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _ew != null
          ? MTPage(
              isLoading: _controller.isLoading,
              navBar: navBar(
                context,
                title: '${_isGoal ? loc.goal_title : loc.task_title} #${_ew!.id}',
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MTButton.icon(plusIcon(context), () => _controller.addEW(context)),
                    SizedBox(width: onePadding * 2),
                    MTButton.icon(editIcon(context), () => _controller.editEW(context)),
                    SizedBox(width: onePadding),
                  ],
                ),
              ),
              body: SafeArea(
                top: false,
                bottom: false,
                child: EWDashboard(_ew!, breadcrumbs: breadcrumbs()),
              ),
            )
          : Container(),
    );
  }
}
