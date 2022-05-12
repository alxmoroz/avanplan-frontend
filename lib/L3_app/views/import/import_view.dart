// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/goals/remote_tracker.dart';
import '../../components/close_dialog_button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/empty_widget.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'import_controller.dart';

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
  ImportController get _controller => importController;

  Widget goalItemBuilder(BuildContext context, int index) {
    final goal = _controller.goals[index];
    return CheckboxListTile(
      title: NormalText(goal.title),
      subtitle: SmallText(goal.description, maxLines: 2),
      value: goal.selected,
      onChanged: (bool? value) => _controller.selectGoal(goal, value!),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget form() {
    final mq = MediaQuery.of(context);
    return Column(children: [
      trackerController.trackers.isEmpty
          ? Expanded(
              child: EmptyDataWidget(
                title: loc.tracker_list_empty_title,
                addTitle: loc.tracker_title_new,
                onAdd: () => _controller.addTracker(context),
              ),
            )
          : MTDropdown<RemoteTracker>(
              width: mq.size.width - onePadding * 2,
              onChanged: (t) => _controller.selectTracker(t),
              value: _controller.selectedTracker,
              items: trackerController.trackers,
              label: loc.tracker_import_placeholder,
            ),
      if (_controller.selectedTracker != null && _controller.goals.isEmpty)
        EmptyDataWidget(
          title: _controller.errorCode != null ? Intl.message(_controller.errorCode!, name: _controller.errorCode) : loc.goal_list_empty_title_import,
          color: _controller.errorCode != null ? warningColor : null,
        ),
      if (_controller.goals.isNotEmpty) ...[
        SizedBox(height: onePadding),
        const MTDivider(),
        Expanded(
          child: ListView.builder(
            itemBuilder: goalItemBuilder,
            itemCount: _controller.goals.length,
          ),
        ),
        const MTDivider(),
        MTButton(
          loc.goal_import,
          _controller.validated ? () => _controller.startImport(context) : null,
          titleColor: _controller.validated ? null : lightGreyColor,
        ),
        SizedBox(height: onePadding),
      ]
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(
          context,
          leading: CloseDialogButton(),
          title: loc.goal_import,
        ),
        body: SafeArea(child: form()),
      ),
    );
  }
}
