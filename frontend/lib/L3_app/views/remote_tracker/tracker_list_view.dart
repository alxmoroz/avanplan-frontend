// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/buttons.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/divider.dart';
import '../../components/icons.dart';
import '../../components/navbar.dart';
import '../../components/splash.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'tracker_controller.dart';

class TrackerListView extends StatefulWidget {
  static String get routeName => 'tracker_list';

  @override
  _TrackerListViewState createState() => _TrackerListViewState();
}

class _TrackerListViewState extends State<TrackerListView> {
  Future<void>? _fetchTrackers;
  TrackerController get controller => trackerController;

  @override
  void initState() {
    _fetchTrackers = controller.fetchTrackers();
    super.initState();
  }

  Widget trackerBuilder(BuildContext context, int index) {
    final tracker = controller.trackers[index];
    return Column(
      children: [
        if (index > 0) const MTDivider(),
        ListTile(
          title: NormalText('${tracker.type.title} ${tracker.title}'),
          subtitle: SmallText(tracker.url),
          trailing: editIcon(context),
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: () => controller.editTracker(context, tracker),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: доработать в соотв. с использованием параметра LOADING в контроллере
    // TODO: FutureBuilder тут очень может быть по ошибке, т.к. не было Observer
    return FutureBuilder(
      future: _fetchTrackers,
      builder: (_, snapshot) => snapshot.connectionState == ConnectionState.done
          ? MTCupertinoPage(
              navBar: navBar(
                context,
                title: loc.tracker_list_title,
                trailing: Button.icon(plusIcon(context), () => controller.addTracker(context)),
              ),
              body: Observer(
                builder: (_) => Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: onePadding),
                      if (controller.trackers.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: trackerBuilder,
                            itemCount: controller.trackers.length,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          : const SplashScreen(),
    );
  }
}
