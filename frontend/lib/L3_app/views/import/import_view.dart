// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/goals/remote_tracker.dart';
import '../../components/bottom_sheet.dart';
import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/divider.dart';
import '../../components/dropdown.dart';
import '../../components/empty_widget.dart';
import '../../components/navbar.dart';
import '../../components/splash.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../remote_tracker/tracker_controller.dart';
import 'import_controller.dart';

Future showImportDialog(BuildContext context) async {
  return await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => MTBottomSheet(ImportView()),
  );
}

class ImportView extends StatefulWidget {
  static String get routeName => 'import';

  @override
  _ImportViewState createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> {
  Future<void>? _fetchTrackers;
  TrackerController get _trackerController => trackerController;
  ImportController get _importController => importController;

  @override
  void initState() {
    _fetchTrackers = _trackerController.fetchTrackers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget goalItemBuilder(BuildContext context, int index) {
    final goal = _importController.goals[index];
    return CheckboxListTile(
      title: NormalText(goal.title),
      subtitle: SmallText(goal.description, maxLines: 2),
      value: goal.selected,
      onChanged: (bool? value) => _importController.selectGoal(goal, value!),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget form() {
    final mq = MediaQuery.of(context);
    return Container(
      constraints: BoxConstraints(maxHeight: (mq.size.height - mq.viewInsets.bottom - mq.viewPadding.bottom) * 0.82),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: _trackerController.trackers.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              if (_trackerController.trackers.isEmpty)
                EmptyDataWidget(
                  title: loc.tracker_list_empty_title,
                  addTitle: loc.tracker_title_new,
                  onAdd: () => _importController.addTracker(context),
                ),
              if (_trackerController.trackers.isNotEmpty)
                MTDropdown<RemoteTracker>(
                  width: mq.size.width - onePadding * 2,
                  onChanged: (t) => _importController.selectTracker(t),
                  value: _trackerController.selectedTracker,
                  items: _trackerController.trackers,
                  label: loc.tracker_import_placeholder,
                ),
              if (_trackerController.selectedTracker != null && _importController.goals.isEmpty && _trackerController.trackers.isNotEmpty)
                EmptyDataWidget(
                  title: _importController.errorCode != null
                      ? Intl.message(_importController.errorCode!, name: _importController.errorCode)
                      : loc.goal_list_empty_title_import,
                  color: _importController.errorCode != null ? lightWarningColor : null,
                ),
              if (_importController.goals.isNotEmpty) ...[
                SizedBox(height: onePadding),
                const MTDivider(),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: goalItemBuilder,
                    itemCount: _importController.goals.length,
                  ),
                ),
                const MTDivider(),
                Button(
                  loc.goal_import,
                  _importController.validated ? () => _importController.startImport(context) : null,
                  titleColor: _importController.validated ? mainColor : borderColor,
                ),
              ]
            ],
          ),
          if (_importController.isLoading) SplashScreen(color: loaderColor.resolve(context)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchTrackers,
      builder: (_, snapshot) => snapshot.connectionState == ConnectionState.done
          ? Observer(
              builder: (_) => MTCupertinoPage(
                bgColor: darkBackgroundColor,
                navBar: navBar(context, title: loc.goal_import),
                body: form(),
              ),
            )
          : const SplashScreen(),
    );
  }
}
