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

Future showImportDialog(BuildContext context) async {
  return await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => MTBottomSheet(ImportView(), context),
  );
}

class ImportView extends StatefulWidget {
  static String get routeName => 'import';

  @override
  _ImportViewState createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> {
  Widget goalItemBuilder(BuildContext context, int index) {
    final goal = importController.goals[index];
    return CheckboxListTile(
      title: NormalText(goal.title),
      subtitle: SmallText(goal.description, maxLines: 2),
      value: goal.selected,
      onChanged: (bool? value) => importController.selectGoal(goal, value!),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget form() {
    final mq = MediaQuery.of(context);
    return Stack(
      children: [
        Column(children: [
          trackerController.trackers.isEmpty
              ? Expanded(
                  child: EmptyDataWidget(
                    title: loc.tracker_list_empty_title,
                    addTitle: loc.tracker_title_new,
                    onAdd: () => importController.addTracker(context),
                  ),
                )
              : MTDropdown<RemoteTracker>(
                  width: mq.size.width - onePadding * 2,
                  onChanged: (t) => importController.selectTracker(t),
                  value: importController.selectedTracker,
                  items: trackerController.trackers,
                  label: loc.tracker_import_placeholder,
                ),
          if (importController.selectedTracker != null && importController.goals.isEmpty)
            EmptyDataWidget(
              title: importController.errorCode != null
                  ? Intl.message(importController.errorCode!, name: importController.errorCode)
                  : loc.goal_list_empty_title_import,
              color: importController.errorCode != null ? warningColor : null,
            ),
          if (importController.goals.isNotEmpty) ...[
            SizedBox(height: onePadding),
            const MTDivider(),
            Expanded(
              child: ListView.builder(
                itemBuilder: goalItemBuilder,
                itemCount: importController.goals.length,
              ),
            ),
            const MTDivider(),
            Button(
              loc.goal_import,
              importController.validated ? () => importController.startImport(context) : null,
              titleColor: importController.validated ? null : lightGreyColor,
            ),
            SizedBox(height: onePadding),
          ]
        ]),
        if (importController.isLoading) SplashScreen(color: loaderColor.resolve(context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        navBar: navBar(context, title: loc.goal_import),
        body: form(),
      ),
    );
  }
}
