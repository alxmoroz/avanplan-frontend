// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/source_type.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_adaptive.dart';
import '../../components/mt_button.dart';
import '../../components/mt_checkbox.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_limit_badge.dart';
import '../../components/mt_shadowed.dart';
import '../../components/mt_toolbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_available_actions.dart';
import '../../usecases/ws_ext_sources.dart';
import '../source/no_sources.dart';
import '../source/source_edit_view.dart';
import 'import_controller.dart';

// старт сценария по импорту задач
Future importTasks(int wsId, {SourceType? sType}) async {
  final controller = await ImportController().init(wsId, sType);
  controller.ws.checkSources();
  await showImportDialog(controller);
}

Future<String?> showImportDialog(ImportController controller) async => await showMTDialog<String?>(ImportView(controller));

class ImportView extends StatelessWidget {
  const ImportView(this.controller);
  final ImportController controller;

  bool get _hasProjects => controller.projects.isNotEmpty;
  bool get _hasError => controller.errorCode != null;
  bool get _validated => controller.validated;
  bool get _selectedAll => controller.selectedAll;
  bool get _sourceSelected => controller.selectedSource != null;
  bool get _hasSources => controller.ws.sources.isNotEmpty;
  bool get _showSelectAll => controller.projects.length > 2;

  Widget get _sourceDropdown => MTDropdown<Source>(
        onChanged: controller.selectSourceId,
        value: controller.selectedSourceId,
        ddItems: [
          for (final s in controller.ws.sortedSources)
            DropdownMenuItem<int>(
              value: s.id,
              child: Padding(
                padding: const EdgeInsets.only(right: P),
                child: s.listTile(
                  padding: EdgeInsets.zero,
                  standAlone: false,
                ),
              ),
            )
        ],
        label: loc.source_import_placeholder,
        margin: const EdgeInsets.symmetric(horizontal: P),
      );

  Widget get _header => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _sourceDropdown),
              MTPlusButton(() async => await startAddSource(controller.ws), type: ButtonType.secondary),
            ],
          ),
          if (_sourceSelected) ...[
            const SizedBox(height: P),
            if (_hasProjects) ...[
              if (_showSelectAll)
                MTCheckBoxTile(
                  title: '${loc.select_all_action_title} (${controller.projects.length})',
                  titleColor: mainColor,
                  color: backgroundColor,
                  bottomBorder: true,
                  value: _selectedAll,
                  onChanged: controller.toggleSelectedAll,
                ),
            ]
          ]
        ],
      );

  Widget get _body => _hasError
      ? ListView(
          shrinkWrap: true,
          children: [
            MediumText(
              _hasError ? Intl.message(controller.errorCode!) : loc.import_list_empty_title,
              align: TextAlign.center,
              color: _hasError ? warningColor : lightGreyColor,
            ),
          ],
        )
      : _hasSources
          ? MTShadowed(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: _projectItemBuilder,
                itemCount: controller.projects.length,
              ),
            )
          : NoSources();

  Widget _projectItemBuilder(BuildContext context, int index) {
    final project = controller.projects[index];
    final value = project.selected;
    return MTCheckBoxTile(
      title: project.title,
      value: value,
      bottomBorder: index < controller.projects.length - 1,
      onChanged: (bool? value) => controller.selectProject(project, value),
    );
  }

  String get _importBtnCountHint => controller.selectedProjects.isNotEmpty ? ' (${controller.selectedProjects.length})' : '';
  String get _importActionHint =>
      '${loc.import_projects_select_available_count_hint(controller.ws.availableProjectsCount)} ${loc.project_plural_genitive(controller.ws.availableProjectsCount)}';

  Widget? get _bottomBar => _hasProjects
      ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          LightText(
            _importActionHint,
            color: _validated ? null : warningColor,
            align: TextAlign.center,
          ),
          const SizedBox(height: P_2),
          MTAdaptive.XS(
            MTLimitBadge(
              child: MTButton.main(
                constrained: false,
                titleText: '${loc.import_action_title}$_importBtnCountHint',
                onTap: _validated ? controller.startImport : null,
              ),
              showBadge: controller.selectableCount < 0,
            ),
          ),
        ])
      : !_hasSources
          ? MTButton.main(
              leading: const PlusIcon(color: lightBackgroundColor),
              titleText: loc.source_title_new,
              onTap: () async => await startAddSource(controller.ws),
            )
          : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(
          middle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.ws.subPageTitle(loc.import_title),
              if (_hasSources) _header,
            ],
          ),
        ),
        topBarHeight: P2 * 2 + (_hasSources ? P * (6.5 + (_showSelectAll ? 4 : 0)) : 0) + (mainController.workspaces.length > 1 ? P2 : 0),
        body: _body,
        bottomBar: _bottomBar,
        bottomBarHeight: _hasProjects ? P * 11 : null,
      ),
    );
  }
}
