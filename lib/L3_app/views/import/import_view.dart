// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/source.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_checkbox.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import 'import_controller.dart';

Future<String?> showImportDialog(BuildContext context) async {
  sourceController.checkSources();
  return await showModalBottomSheet<String?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(ImportView()),
  );
}

class ImportView extends StatelessWidget {
  ImportController get _controller => importController;
  bool get _hasProjects => _controller.projects.isNotEmpty;
  bool get _hasError => _controller.errorCode != null;
  bool get _validated => _controller.validated;
  bool get _selectedAll => _controller.selectedAll;

  List<DropdownMenuItem<Source>> _srcDdItems(Iterable<Source> sources, BuildContext context) =>
      [for (final s in sources) DropdownMenuItem<Source>(value: s, child: Padding(padding: const EdgeInsets.only(right: P), child: s.info(context)))];

  Widget _sourceDropdown(BuildContext context) => MTDropdown<Source>(
        onChanged: (s) => _controller.selectSource(s),
        value: _controller.selectedSource,
        ddItems: _srcDdItems(sourceController.sources, context),
        label: loc.source_import_placeholder,
        dense: false,
        margin: const EdgeInsets.symmetric(horizontal: P),
      );

  Widget _header(BuildContext context) => Column(
        children: [
          const SizedBox(height: P2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _sourceDropdown(context)),
              MTPlusButton(() => _controller.needAddSourceEvent(context)),
            ],
          ),
          if (_controller.selectedSource != null) ...[
            if (_hasProjects) ...[
              if (_controller.projects.length > 1)
                MTCheckBoxTile(title: loc.select_all_action_title, value: _selectedAll, onChanged: _controller.toggleSelectedAll),
            ] else
              MediumText(
                _hasError ? Intl.message(_controller.errorCode!) : loc.import_list_empty_title,
                align: TextAlign.center,
                color: _hasError ? warningColor : lightGreyColor,
                padding: const EdgeInsets.only(top: P_2),
              ),
          ] else
            NormalText(loc.import_source_select_hint, color: warningColor, align: TextAlign.center, padding: const EdgeInsets.only(top: P)),
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
                itemCount: _controller.projects.length,
              ),
            ),
        ],
      );

  Widget _projectItemBuilder(BuildContext context, int index) {
    final project = _controller.projects[index];
    final value = project.selected;
    return MTCheckBoxTile(
      title: project.title,
      description: project.description,
      value: value,
      onChanged: (bool? value) => _controller.selectProject(project, value),
    );
  }

  Widget? _bottomBar(BuildContext context) => _controller.selectedSource != null && _hasProjects
      ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (!_validated)
            NormalText(
              loc.import_projects_select_hint,
              color: warningColor,
              align: TextAlign.center,
              padding: const EdgeInsets.only(bottom: P_2),
            ),
          MTButton.outlined(
            titleText: loc.import_action_title,
            margin: const EdgeInsets.symmetric(horizontal: P),
            onTap: _validated ? () => _controller.startImport(context) : null,
          )
        ])
      : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, leading: MTCloseButton(), title: loc.import_title, bgColor: darkBackgroundColor),
        body: SafeArea(bottom: false, child: _body(context)),
        bottomBar: _bottomBar(context),
      ),
    );
  }
}
