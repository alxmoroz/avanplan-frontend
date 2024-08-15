// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/checkbox.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/dropdown.dart';
import '../../components/shadowed.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_sources.dart';
import '../_base/loader_screen.dart';
import '../source/no_sources.dart';
import '../source/source_edit_dialog.dart';
import 'import_controller.dart';

// старт сценария по импорту задач
Future importTasks(Workspace ws) async {
  final controller = await ImportController().init(ws);
  controller.ws.checkSources();
  await showMTDialog<void>(_ImportDialog(controller));
}

class _ImportDialog extends StatelessWidget {
  const _ImportDialog(this.controller);
  final ImportController controller;

  bool get _hasProjects => controller.projects.isNotEmpty;
  bool get _hasError => controller.errorCode != null;
  bool get _validated => controller.validated;
  bool get _selectedAll => controller.selectedAll;
  bool get _sourceSelected => controller.selectedSourceId != null;
  bool get _hasSources => controller.ws.sources.isNotEmpty;
  bool get _showSelectAll => controller.projects.length > 2;

  Widget get _sourceDropdown => MTDropdown<Source>(
        onChanged: controller.selectSource,
        value: controller.selectedSourceId,
        ddItems: [
          for (final s in controller.ws.sortedSources)
            DropdownMenuItem<int>(
              value: s.id,
              child: Padding(
                padding: const EdgeInsets.only(right: P2),
                child: s.listTile(padding: EdgeInsets.zero, standAlone: false),
              ),
            )
        ],
        label: loc.source_import_placeholder,
        margin: const EdgeInsets.symmetric(horizontal: P3),
      );

  Widget get _header => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P),
          Row(
            children: [
              Expanded(child: _sourceDropdown),
              MTPlusButton(() async => await startAddSource(controller.ws), type: ButtonType.secondary),
            ],
          ),
          if (_sourceSelected) ...[
            const SizedBox(height: P2),
            if (_hasProjects) ...[
              if (_showSelectAll)
                MTCheckBoxTile(
                  title: '${loc.select_all_action_title} (${controller.selectableProjects.length})',
                  titleColor: mainColor,
                  color: b2Color,
                  value: _selectedAll,
                  onChanged: controller.toggleSelectedAll,
                  bottomDivider: false,
                ),
            ]
          ]
        ],
      );

  Widget _projectItemBuilder(BuildContext context, int index) {
    final project = controller.projects[index];
    final value = project.selected;
    final importing = controller.isImporting(project);
    return MTCheckBoxTile(
      title: project.title,
      description: importing ? loc.state_importing_label : null,
      value: value,
      bottomDivider: index < controller.projects.length - 1,
      onChanged: importing ? null : (bool? value) => controller.selectProject(project, value),
    );
  }

  Widget _body(BuildContext context) => _hasError
      ? ListView(
          shrinkWrap: true,
          children: [
            BaseText.medium(
              _hasError ? Intl.message(controller.errorCode!) : loc.import_list_empty_title,
              align: TextAlign.center,
              color: _hasError ? dangerColor : f2Color,
            ),
          ],
        )
      : _hasSources
          ? MTShadowed(
              shadowColor: b1Color,
              bottomShadow: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: _projectItemBuilder,
                itemCount: controller.projects.length,
              ),
            )
          : NoSources(controller.ws);

  String get _importBtnCountHint => controller.selectedProjects.isNotEmpty ? ' (${controller.selectedProjects.length})' : '';

  PreferredSizeWidget? _bottomBar(BuildContext context) => _hasProjects
      ? MTAppBar(
          isBottom: true,
          inDialog: true,
          color: b2Color,
          padding: EdgeInsets.only(top: P2, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
          middle: MTButton.main(
            padding: const EdgeInsets.symmetric(horizontal: P3),
            titleText: '${loc.import_action_title}$_importBtnCountHint',
            onTap: _validated ? () => controller.startImport(context) : null,
          ),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => controller.loading
          ? LoaderScreen(controller, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                showCloseButton: true,
                color: b2Color,
                innerHeight: P8 + (_hasSources ? P * 15 + (_showSelectAll ? P8 : 0) : 0),
                middle: controller.ws.subPageTitle(loc.import_title),
                bottom: _hasSources ? _header : null,
              ),
              body: _body(context),
              bottomBar: _bottomBar(context),
            ),
    );
  }
}
