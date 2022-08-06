// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/source.dart';
import '../../components/close_dialog_button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'import_controller.dart';

Future<String?> showImportDialog(BuildContext context) async {
  return await showModalBottomSheet<String?>(
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

  Widget taskItemBuilder(BuildContext context, int index) {
    final task = _controller.remoteTasks[index];
    return CheckboxListTile(
      title: NormalText(task.title),
      subtitle: SmallText(task.description, maxLines: 2),
      value: task.selected,
      onChanged: (bool? value) => _controller.selectTask(task, value!),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget get sourceDropdown => sourceController.sources.isEmpty
      ? Expanded(
          child: EmptyDataWidget(
            title: loc.source_list_empty_title,
            addTitle: loc.source_title_new,
            onAdd: () => _controller.addSource(context),
          ),
        )
      : MTDropdown<Source>(
          onChanged: (t) => _controller.selectSource(t),
          value: _controller.selectedSource,
          items: sourceController.sources,
          label: loc.source_import_placeholder,
        );

  Widget form() {
    return Column(children: [
      sourceDropdown,
      if (_controller.selectedSource != null) ...[
        if (_controller.remoteTasks.isEmpty)
          EmptyDataWidget(
            title:
                _controller.errorCode != null ? Intl.message(_controller.errorCode!, name: _controller.errorCode) : loc.task_list_empty_title_import,
            color: _controller.errorCode != null ? warningColor : null,
          ),
        if (_controller.remoteTasks.isNotEmpty) ...[
          SizedBox(height: onePadding),
          const MTDivider(),
          Expanded(
            child: ListView.builder(
              itemBuilder: taskItemBuilder,
              itemCount: _controller.remoteTasks.length,
            ),
          ),
          const MTDivider(),
          SizedBox(height: onePadding),
          MTButton(
            loc.task_import_connect_button_title,
            _controller.validated ? () => _controller.startImport(context) : null,
            titleColor: _controller.validated ? null : lightGreyColor,
          ),
          SmallText(loc.common_or, color: darkGreyColor, padding: EdgeInsets.symmetric(vertical: onePadding / 2)),
          MTButton(
            loc.task_import_copy_button_title,
            _controller.validated ? () => _controller.startImport(context, keepConnection: false) : null,
            titleColor: _controller.validated ? null : lightGreyColor,
          ),
          SizedBox(height: onePadding),
        ],
      ],
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(context, leading: CloseDialogButton(), title: loc.task_import_title),
        body: SafeArea(child: form()),
      ),
    );
  }
}
