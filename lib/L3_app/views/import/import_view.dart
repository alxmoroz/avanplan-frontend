// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/source.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_checkbox.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
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
  bool get hasProjects => _controller.remoteTasks.isNotEmpty;
  bool get hasError => _controller.errorCode != null;
  bool get validated => _controller.validated;
  bool get selectedAll => _controller.selectedAll;

  Widget itemBuilder(BuildContext context, int index) {
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
            child: s.info(context),
          ))
      .toList();

  Widget get sourceDropdown => MTDropdown<Source>(
        onChanged: (s) => _controller.selectSource(s),
        value: _controller.selectedSource,
        ddItems: srcDdItems(sourceController.sources),
        label: loc.source_import_placeholder,
        dense: false,
      );

  Widget get _header => Column(
        children: [
          sourceDropdown,
          if (_controller.selectedSource != null) ...[
            SizedBox(height: onePadding),
            if (hasProjects) ...[
              if (_controller.remoteTasks.length > 1)
                MTCheckBoxTile(title: loc.select_all_action_title, value: selectedAll, onChanged: _controller.toggleSelectedAll),
            ] else
              MediumText(
                hasError ? Intl.message(_controller.errorCode!) : loc.import_list_empty_title,
                align: TextAlign.center,
                color: hasError ? warningColor : lightGreyColor,
              ),
          ] else
            NormalText(loc.import_source_select_hint, color: warningColor, align: TextAlign.center, padding: EdgeInsets.only(top: onePadding)),
        ],
      );

  Widget get _body => Column(
        children: [
          _header,
          if (_controller.selectedSource != null)
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: itemBuilder,
                itemCount: _controller.remoteTasks.length,
              ),
            ),
        ],
      );

  Widget? get _bottomBar => _controller.selectedSource != null
      ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (!validated)
            NormalText(
              loc.import_projects_select_hint,
              color: warningColor,
              align: TextAlign.center,
              padding: EdgeInsets.only(bottom: onePadding / 2),
            ),
          MTButton.outlined(
            titleString: loc.import_action_title,
            margin: EdgeInsets.symmetric(horizontal: onePadding),
            onTap: validated ? () => _controller.startImport(context) : null,
          )
        ])
      : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          title: loc.import_title,
          trailing: sourceController.sources.isNotEmpty
              ? MTButton.icon(plusIcon(context), () => _controller.needAddSourceEvent(context), margin: EdgeInsets.only(right: onePadding))
              : null,
        ),
        body: SafeArea(bottom: false, child: _body),
        bottomBar: _bottomBar,
      ),
    );
  }
}
