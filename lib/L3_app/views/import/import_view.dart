// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/source.dart';
import '../../components/close_dialog_button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_action.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_checkbox.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../../presenters/task_source_presenter.dart';
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
  bool get hasTasks => _controller.remoteTasks.isNotEmpty;
  bool get hasError => _controller.errorCode != null;
  bool get validated => _controller.validated;
  bool get selectedAll => _controller.selectedAll;

  Widget taskItemBuilder(BuildContext context, int index) {
    final task = _controller.remoteTasks[index];
    final value = task.selected;
    return MTCheckBoxTile(
      title: task.title,
      description: task.description,
      value: value,
      onChanged: (bool? value) => _controller.selectTask(task, value!),
    );
  }

  List<DropdownMenuItem<Source>> srcDdItems(Iterable<Source> sources) => sources
      .map((s) => DropdownMenuItem<Source>(
            value: s,
            child: sourceInfo(context, s),
          ))
      .toList();

  Widget get sourceDropdown => sourceController.sources.isEmpty
      ? Expanded(
          child: MTFloatingAction(
            hint: loc.source_list_empty_title,
            title: loc.source_title_new,
            icon: plusIcon(context, size: 24),
            onPressed: () => _controller.needAddSource(context),
          ),
        )
      : MTDropdown<Source>(
          onChanged: (s) => _controller.selectSource(s),
          value: _controller.selectedSource,
          ddItems: srcDdItems(sourceController.sources),
          label: loc.source_import_placeholder,
          dense: false,
        );

  Widget form() {
    return Column(children: [
      sourceDropdown,
      if (_controller.selectedSource != null) ...[
        if (!hasTasks)
          MTFloatingAction(
            hint: hasError ? Intl.message(_controller.errorCode!, name: _controller.errorCode) : loc.task_import_list_empty_title,
            hintColor: hasError ? warningColor : null,
          ),
        if (hasTasks) ...[
          SizedBox(height: onePadding),
          if (_controller.remoteTasks.length > 1)
            MTCheckBoxTile(title: loc.common_select_all_title, value: selectedAll, onChanged: _controller.toggleSelectedAll),
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
            loc.task_import_btn_title,
            validated ? () => _controller.startImport(context) : null,
            titleColor: validated ? null : lightGreyColor,
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
        navBar: navBar(
          context,
          leading: CloseDialogButton(),
          title: loc.task_import_title,
          trailing: sourceController.sources.isNotEmpty
              ? MTButton.icon(plusIcon(context), () => _controller.needAddSource(context), padding: EdgeInsets.only(right: onePadding))
              : const SizedBox(width: 0),
        ),
        body: SafeArea(child: form()),
      ),
    );
  }
}
