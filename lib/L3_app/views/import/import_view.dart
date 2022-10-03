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

class ImportView extends StatelessWidget {
  static String get routeName => 'import';

  ImportController get _controller => importController;
  bool get _hasProjects => _controller.remoteTasks.isNotEmpty;
  bool get _hasError => _controller.errorCode != null;
  bool get _validated => _controller.validated;
  bool get _selectedAll => _controller.selectedAll;

  List<DropdownMenuItem<Source>> _srcDdItems(Iterable<Source> sources, BuildContext context) => [
        for (final s in sources) DropdownMenuItem<Source>(value: s, child: s.info(context)),
        DropdownMenuItem<Source>(
          value: Source(workspaceId: -1, type: SourceType(id: -1, title: ''), url: 'none'),
          child: Row(children: [plusIcon(context), MediumText(loc.source_title_new, color: mainColor)]),
        ),
      ];

  Widget _sourceDropdown(BuildContext context) => MTDropdown<Source>(
        onChanged: (s) => s?.id != null ? _controller.selectSource(s) : _controller.needAddSourceEvent(context),
        value: _controller.selectedSource,
        ddItems: _srcDdItems(sourceController.sources, context),
        label: loc.source_import_placeholder,
        dense: false,
      );

  Widget _header(BuildContext context) => Column(
        children: [
          _sourceDropdown(context),
          if (_controller.selectedSource != null) ...[
            SizedBox(height: onePadding),
            if (_hasProjects) ...[
              if (_controller.remoteTasks.length > 1)
                MTCheckBoxTile(title: loc.select_all_action_title, value: _selectedAll, onChanged: _controller.toggleSelectedAll),
            ] else
              MediumText(
                _hasError ? Intl.message(_controller.errorCode!) : loc.import_list_empty_title,
                align: TextAlign.center,
                color: _hasError ? warningColor : lightGreyColor,
              ),
          ] else
            NormalText(loc.import_source_select_hint, color: warningColor, align: TextAlign.center, padding: EdgeInsets.only(top: onePadding)),
        ],
      );

  Widget _body(BuildContext context) => Column(
        children: [
          _header(context),
          if (_controller.selectedSource != null)
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: _projectItemBuilder,
                itemCount: _controller.remoteTasks.length,
              ),
            ),
        ],
      );

  Widget _projectItemBuilder(BuildContext context, int index) {
    final task = _controller.remoteTasks[index];
    final value = task.selected;
    return MTCheckBoxTile(
      title: task.title,
      description: task.description,
      value: value,
      onChanged: (bool? value) => _controller.selectTask(task, value!),
    );
  }

  Widget? _bottomBar(BuildContext context) => _controller.selectedSource != null && _hasProjects
      ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (!_validated)
            NormalText(
              loc.import_projects_select_hint,
              color: warningColor,
              align: TextAlign.center,
              padding: EdgeInsets.only(bottom: onePadding / 2),
            ),
          MTButton.outlined(
            titleString: loc.import_action_title,
            margin: EdgeInsets.symmetric(horizontal: onePadding),
            onTap: _validated ? () => _controller.startImport(context) : null,
          )
        ])
      : null;

  // MTButton.icon(plusIcon(context), () => _controller.needAddSourceEvent(context), margin: EdgeInsets.only(right: onePadding))

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(context, leading: MTCloseButton(), title: loc.import_title),
        body: SafeArea(bottom: false, child: _body(context)),
        bottomBar: _bottomBar(context),
      ),
    );
  }
}
