// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_checkbox.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_limit_badge.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../presenters/ws_presenter.dart';
import '../../usecases/ws_ext_actions.dart';
import '../source/source_add_menu.dart';
import 'import_controller.dart';

// старт сценария по импорту задач
Future importTasks({bool needAddSource = false, String? sType}) async {
  final controller = await ImportController().init(needAddSource, sType);

  // если вернулись из диалога с желанием добавить источник импорта, то опять пытаемся добавить источник импорта
  // диалог с импортом задач
  final st = await showImportDialog(controller);
  if (st != null) {
    await importTasks(needAddSource: true, sType: st);
  }
}

Future<String?> showImportDialog(ImportController controller) async => await showModalBottomSheet<String?>(
      context: rootKey.currentContext!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MTBottomSheet(ImportView(controller)),
    );

class ImportView extends StatelessWidget {
  const ImportView(this.controller);
  final ImportController controller;

  Workspace get ws => mainController.selectedWS!;

  bool get _hasProjects => controller.projects.isNotEmpty;
  bool get _hasError => controller.errorCode != null;
  bool get _validated => controller.validated;
  bool get _selectedAll => controller.selectedAll;

  Widget _sourceDropdown(BuildContext context) => MTDropdown<Source>(
        onChanged: (s) => controller.selectSource(s),
        value: controller.selectedSource,
        ddItems: [
          for (final s in ws.sortedSources)
            DropdownMenuItem<Source>(value: s, child: Padding(padding: const EdgeInsets.only(right: P), child: s.info(context)))
        ],
        label: loc.source_import_placeholder,
        margin: const EdgeInsets.symmetric(horizontal: P),
      );

  Widget _header(BuildContext context) => Column(
        children: [
          const SizedBox(height: P2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _sourceDropdown(context)),
              SourceAddMenu(
                onSelected: (st) => controller.needAddSourceEvent(context, st),
              ),
              const SizedBox(width: P),
            ],
          ),
          if (controller.selectedSource != null) ...[
            if (_hasProjects) ...[
              if (controller.projects.length > 2)
                MTCheckBoxTile(
                    title: '${loc.select_all_action_title} (${controller.projects.length})',
                    titleColor: mainColor,
                    value: _selectedAll,
                    onChanged: controller.toggleSelectedAll),
            ] else
              MediumText(
                _hasError ? Intl.message(controller.errorCode!) : loc.import_list_empty_title,
                align: TextAlign.center,
                color: _hasError ? warningColor : lightGreyColor,
                padding: const EdgeInsets.only(top: P_2),
              ),
          ] else
            NormalText(loc.import_source_select_hint, color: warningColor, align: TextAlign.center, padding: const EdgeInsets.only(top: P)),
        ],
      );

  Widget _body(BuildContext context) => ws.sources.isNotEmpty
      ? Column(
          children: [
            _header(context),
            if (controller.selectedSource != null)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: _projectItemBuilder,
                  itemCount: controller.projects.length,
                ),
              ),
          ],
        )
      : Center(child: H4(loc.source_list_empty_title, align: TextAlign.center, color: lightGreyColor));

  Widget _projectItemBuilder(BuildContext context, int index) {
    final project = controller.projects[index];
    final value = project.selected;
    return MTCheckBoxTile(
      title: project.title,
      // description: project.description,
      value: value,
      onChanged: (bool? value) => controller.selectProject(project, value),
    );
  }

  String get _importBtnCountHint => controller.selectedProjects.isNotEmpty ? ' (${controller.selectedProjects.length})' : '';
  String get _importActionHint =>
      '${loc.import_projects_select_available_count_hint(ws.availableProjectsCount)} ${loc.project_plural_genitive(ws.availableProjectsCount)}';

  Widget? _bottomBar(BuildContext context) => controller.selectedSource != null && _hasProjects
      ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          LightText(
            _importActionHint,
            color: _validated ? null : warningColor,
            align: TextAlign.center,
            padding: const EdgeInsets.only(top: P_2),
          ),
          const SizedBox(height: P_2),
          MTLimitBadge(
            child: MTButton.outlined(
              titleText: '${loc.import_action_title}$_importBtnCountHint',
              margin: EdgeInsets.only(left: controller.selectableCount >= 0 ? P : MTLimitBadge.childLeftMargin, right: P),
              onTap: _validated ? () => controller.startImport(context) : null,
            ),
            showBadge: controller.selectableCount < 0,
          ),
        ])
      : ws.sources.isEmpty
          ? SourceAddMenu(
              onSelected: (st) => controller.needAddSourceEvent(context, st),
              title: loc.source_title_new,
            )
          : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, leading: MTCloseButton(), title: loc.import_title, bgColor: backgroundColor),
        body: SafeArea(bottom: false, child: _body(context)),
        bottomBar: _bottomBar(context),
      ),
    );
  }
}
