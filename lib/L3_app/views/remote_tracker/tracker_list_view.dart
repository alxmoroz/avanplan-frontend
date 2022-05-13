// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_circle.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'tracker_controller.dart';

class TrackerListView extends StatefulWidget {
  static String get routeName => 'tracker_list';

  @override
  _TrackerListViewState createState() => _TrackerListViewState();
}

class _TrackerListViewState extends State<TrackerListView> {
  TrackerController get _controller => trackerController;

  Widget trackerBuilder(BuildContext _, int index) {
    final tracker = _controller.trackers[index];
    return Column(
      children: [
        if (index > 0) const MTDivider(),
        ListTile(
          leading: MTCircle(color: tracker.connected ? Colors.green : warningColor),
          title: NormalText('${tracker.type.title} ${tracker.description}'),
          subtitle: SmallText(tracker.url),
          trailing: editIcon(context),
          minLeadingWidth: 0,
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: () => _controller.editTracker(context, tracker),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(
          context,
          title: loc.tracker_list_title,
          trailing: MTButton.icon(plusIcon(context), () => _controller.addTracker(context), padding: EdgeInsets.only(right: onePadding)),
        ),
        body: _controller.trackers.isEmpty
            ? EmptyDataWidget(
                title: loc.tracker_list_empty_title,
                addTitle: loc.tracker_title_new,
                onAdd: () => _controller.addTracker(context),
              )
            : ListView.builder(
                itemBuilder: trackerBuilder,
                itemCount: _controller.trackers.length,
              ),
      ),
    );
  }
}
