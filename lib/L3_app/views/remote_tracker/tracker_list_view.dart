// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/buttons.dart';
import '../../components/circle.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/divider.dart';
import '../../components/empty_widget.dart';
import '../../components/icons.dart';
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
          leading: CircleWidget(color: tracker.connected ? Colors.green : warningColor),
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

  // TODO:  нужно добавить индикатор загрузки такой ещё:
  //  if (controller.isLoading) SplashScreen(color: loaderColor.resolve(context)),

  @override
  Widget build(BuildContext context) {
    return MTCupertinoPage(
      navBar: navBar(
        context,
        title: loc.tracker_list_title,
        trailing: Button.icon(plusIcon(context), () => _controller.addTracker(context)),
      ),
      body: Observer(
        builder: (context) => Column(children: [
          SizedBox(height: onePadding),
          Expanded(
            child: _controller.trackers.isEmpty
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
        ]),
      ),
    );
  }
}
