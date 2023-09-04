// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/source_type.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/checkbox.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/dropdown.dart';
import '../../components/icons.dart';
import '../../components/limit_badge.dart';
import '../../components/shadowed.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_actions.dart';
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

Future showImportDialog(ImportController controller) async => await showMTDialog<void>(ImportView(controller));

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
                padding: const EdgeInsets.only(right: P2),
                child: s.listTile(
                  padding: EdgeInsets.zero,
                  standAlone: false,
                ),
              ),
            )
        ],
        label: loc.source_import_placeholder,
        margin: const EdgeInsets.symmetric(horizontal: P3),
      );

  Widget get _header => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P4),
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
                  title: '${loc.select_all_action_title} (${controller.projects.length})',
                  titleColor: mainColor,
                  color: b2Color,
                  value: _selectedAll,
                  onChanged: controller.toggleSelectedAll,
                ),
            ]
          ]
        ],
      );

  Widget _projectItemBuilder(BuildContext context, int index) {
    final project = controller.projects[index];
    final value = project.selected;
    return MTCheckBoxTile(
      title: project.title,
      value: value,
      bottomDivider: index < controller.projects.length - 1,
      onChanged: (bool? value) => controller.selectProject(project, value),
    );
  }

  Widget _body(BuildContext context) => _hasError
      ? ListView(
          shrinkWrap: true,
          children: [
            BaseText.medium(
              _hasError ? Intl.message(controller.errorCode!) : loc.import_list_empty_title,
              align: TextAlign.center,
              color: _hasError ? warningColor : f2Color,
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
              bottomShadow: true,
            )
          : NoSources();

  String get _importBtnCountHint => controller.selectedProjects.isNotEmpty ? ' (${controller.selectedProjects.length})' : '';
  String get _importActionHint =>
      '${loc.import_projects_select_available_count_hint(controller.ws.availableProjectsCount)} ${loc.project_plural_genitive(controller.ws.availableProjectsCount)}';

  Widget? get _bottomBar => _hasProjects
      ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SmallText(
            _importActionHint,
            height: 1,
            color: _validated ? f2Color : warningColor,
            align: TextAlign.center,
          ),
          const SizedBox(height: P),
          MTAdaptive.XS(
            child: MTLimitBadge(
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
              leading: const PlusIcon(color: mainBtnTitleColor),
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
        topBarHeight: P8 + (_hasSources ? P * (13 + (_showSelectAll ? 8 : 0)) : 0) + (mainController.workspaces.length > 1 ? P4 : 0),
        body: _body(context),
        bottomBar: _bottomBar,
        bottomBarHeight: _hasProjects ? P * 19 : null,
      ),
    );
  }
}
