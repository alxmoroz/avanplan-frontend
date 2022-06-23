// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_divider.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'ew_view_controller.dart';

class EWHeader extends StatelessWidget {
  const EWHeader(this.element);

  final ElementOfWork element;

  bool get hasLink => element.trackerId != null;
  bool get isClosed => element.closed;
  EWViewController get _controller => ewViewController;

  String get breadcrumbs {
    const sepStr = ' ⟩ ';
    String _breadcrumbs = '';
    if (!(element is Goal)) {
      final titles = _controller.navStackTasks.take(_controller.navStackTasks.length - 1).map((pt) => pt.title).toList();
      titles.insert(0, _controller.selectedGoal!.title);
      _breadcrumbs = titles.join(sepStr);
    }
    return _breadcrumbs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(onePadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (breadcrumbs.isNotEmpty) ...[
          SmallText(breadcrumbs),
          const MTDivider(),
        ],
        Row(children: [
          Expanded(child: H2(element.title, decoration: isClosed ? TextDecoration.lineThrough : null)),
          SizedBox(width: onePadding / 2),
          if (hasLink) ...[
            SizedBox(height: onePadding / 2),
            linkIcon(context, color: darkGreyColor),
          ],
        ]),
      ]),
    );
  }
}
