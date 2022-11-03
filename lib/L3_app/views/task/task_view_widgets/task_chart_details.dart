// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_bottom_sheet.dart';
import '../../../components/mt_close_button.dart';
import '../../../components/mt_page.dart';
import '../../../components/navbar.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
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
        child: ListView(
          padding: padding.add(EdgeInsets.symmetric(horizontal: onePadding)),
          children: [
            if (task.showSpeedVolumeCharts) ...[
              /// объем
              H3(loc.task_charts_volume_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
              Row(children: [
                TaskVolumeChart(task),
                Column(children: []),
              ]),

              /// скорость
              H3(loc.task_charts_speed_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
              Row(children: [
                TaskSpeedChart(task),
                Column(children: []),
              ]),
            ],

            /// срок
            if (task.showTimeChart) ...[
              H3(loc.task_charts_timings_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
              TaskTimeChart(task),
            ],
          ],
        ),
      ),
    );
  }
}
