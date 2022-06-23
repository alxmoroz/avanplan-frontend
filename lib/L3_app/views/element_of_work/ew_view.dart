// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'ew_header.dart';
import 'ew_list.dart';
import 'ew_overview.dart';
import 'ew_view_controller.dart';

class EWView extends StatelessWidget {
  static String get routeName => 'element_of_work';

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ewViewController.selectedEW != null ? EWPage(ewViewController.selectedEW!) : Container(),
    );
  }
}

enum _TabKeys { overview, tasks }

class EWPage extends StatefulWidget {
  const EWPage(this.ew);

  final ElementOfWork ew;

  @override
  _EWPageState createState() => _EWPageState();
}

class _EWPageState extends State<EWPage> {
  _TabKeys? tabKeyValue = _TabKeys.overview;

  ElementOfWork get ew => widget.ew;
  bool get isGoal => ew is Goal;
  bool get hasSubtasks => ew.tasksCount > 0;
  EWViewController get _controller => ewViewController;

  Widget tabPaneSelector() => Padding(
        padding: EdgeInsets.symmetric(horizontal: onePadding),
        child: CupertinoSlidingSegmentedControl<_TabKeys>(
          children: {
            _TabKeys.overview: NormalText(loc.overview),
            _TabKeys.tasks: NormalText(loc.tasks_title),
          },
          groupValue: tabKeyValue,
          onValueChanged: (value) => setState(() => tabKeyValue = value),
        ),
      );

  Widget overviewPane() => EWOverview(ew);

  Widget tasksPane() => Column(
        children: [
          SizedBox(height: onePadding / 2),
          EWList(ewViewController.subtasks),
          SizedBox(height: onePadding),
        ],
      );

  Widget selectedPane() => {_TabKeys.overview: overviewPane(), _TabKeys.tasks: tasksPane()}[tabKeyValue] ?? overviewPane();

  @override
  Widget build(BuildContext context) {
    return MTPage(
      isLoading: _controller.isLoading,
      navBar: navBar(
        context,
        title: '${isGoal ? loc.goal_title : loc.task_title} #${ew.id}',
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
        child: ListView(
          children: [
            EWHeader(ew),
            if (hasSubtasks) ...[
              SizedBox(height: onePadding / 2),
              tabPaneSelector(),
            ],
            selectedPane(),
            if (!hasSubtasks && ew is Goal)
              EmptyDataWidget(
                title: loc.task_list_empty_title,
                addTitle: loc.task_title_new,
                onAdd: () => ewViewController.addTask(context),
              ),
          ],
        ),
      ),
    );
  }
}
