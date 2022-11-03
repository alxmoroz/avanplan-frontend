// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_bottom_sheet.dart';
import '../../../components/mt_close_button.dart';
import '../../../components/mt_page.dart';
import '../../../components/navbar.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/date_presenter.dart';
import '../../../presenters/state_presenter.dart';
import '../task_charts/task_speed_chart.dart';
import '../task_charts/task_time_chart.dart';
import '../task_charts/task_volume_chart.dart';

Future<String?> showChartsDetailsDialog(BuildContext context, Task task) async {
  return await showModalBottomSheet<String?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TaskChartDetails(task)),
  );
}

class TaskChartDetails extends StatelessWidget {
  const TaskChartDetails(this.task);
  @protected
  final Task task;

  Widget _textRow(String t1, String t2, {Color? color}) => Row(children: [
        Expanded(child: LightText(t1, height: 1.1, sizeScale: 1.1)),
        H4(t2, color: color, padding: EdgeInsets.only(top: onePadding / 6, bottom: onePadding / 6))
      ]);

  int get _volumeDelta => task.closedLeafTasksCount - task.planVolume!.round();

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return MTPage(
      navBar: navBar(
        context,
        leading: MTCloseButton(),
        title: loc.task_charts_details_title,
        bgColor: darkBackgroundColor,
      ),
      body: SafeArea(
        bottom: false,
        // top: false,
        child: ListView(padding: padding.add(EdgeInsets.symmetric(horizontal: onePadding)), children: [
          if (task.showSpeedVolumeCharts) ...[
            /// объем
            H3(loc.task_charts_volume_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
            Row(children: [
              TaskVolumeChart(task),
              SizedBox(width: onePadding),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  _textRow(loc.state_closed, '${task.closedLeafTasksCount} / ${task.leafTasksCount}'),
                  _textRow(loc.state_opened, '${task.openedLeafTasksCount}'),
                  if (task.planVolume != null) ...[
                    SizedBox(height: onePadding),
                    _textRow(loc.task_charts_volume_plan_label, '${task.planVolume!.round()}'),
                    if (_volumeDelta != 0)
                      _textRow(
                        _volumeDelta > 0 ? loc.task_charts_volume_delta_ahead_label : loc.task_charts_volume_delta_lag_label,
                        '${_volumeDelta.abs()}',
                        color: _volumeDelta > 0 ? greenColor : warningColor,
                      ),
                  ],
                ]),
              ),
            ]),

            /// скорость
            SizedBox(height: onePadding),
            H3(loc.task_charts_speed_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
            Row(children: [
              TaskSpeedChart(task),
              SizedBox(width: onePadding),
              Expanded(
                child: Column(children: [
                  _textRow(loc.task_charts_speed_project_label, '${(task.projectOrWSSpeed * secondsInMonth).round()}'),
                  if (task.targetSpeed != null) _textRow(loc.task_charts_speed_target_label, '${(task.targetSpeed! * secondsInMonth).round()}'),
                ]),
              ),
            ]),
          ],

          /// срок
          if (task.showTimeChart) ...[
            H3(loc.task_charts_timings_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
            TaskTimeChart(task),
          ],
        ]),
      ),
    );
  }
}
