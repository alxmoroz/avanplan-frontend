// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_checkbox.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_limit_badge.dart';
import '../../components/mt_page.dart';
import '../../components/mt_shadowed.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../presenters/ws_presenter.dart';
import '../../usecases/ws_ext_actions.dart';
import '../../usecases/ws_ext_sources.dart';
import '../source/source_edit_view.dart';
import 'import_controller.dart';

// старт сценария по импорту задач
Future importTasks(int wsId, {String? sType}) async {
  final controller = await ImportController().init(wsId, sType);
  controller.ws.checkSources();
  await showImportDialog(controller);
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

  bool get _hasProjects => controller.projects.isNotEmpty;
  bool get _hasError => controller.errorCode != null;
  bool get _validated => controller.validated;
  bool get _selectedAll => controller.selectedAll;

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
        children: [
          const SizedBox(height: P2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _sourceDropdown),
              MTPlusButton(() => startAddSource(controller.ws), type: ButtonType.secondary),
            ],
          ),
          if (controller.selectedSource != null) ...[
            const SizedBox(height: P),
            if (_hasProjects) ...[
              if (controller.projects.length > 2) ...[
                MTCheckBoxTile(
                  title: '${loc.select_all_action_title} (${controller.projects.length})',
                  titleColor: mainColor,
                  value: _selectedAll,
                  onChanged: controller.toggleSelectedAll,
                ),
              ],
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

  Widget get _body => controller.ws.sources.isNotEmpty
      ? Column(
          children: [
            _header,
            if (controller.selectedSource != null)
              Expanded(
                child: MTShadowed(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: _projectItemBuilder,
                    itemCount: controller.projects.length,
                  ),
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
      value: value,
      bottomBorder: index < controller.projects.length - 1,
      onChanged: (bool? value) => controller.selectProject(project, value),
    );
  }

  String get _importBtnCountHint => controller.selectedProjects.isNotEmpty ? ' (${controller.selectedProjects.length})' : '';
  String get _importActionHint =>
      '${loc.import_projects_select_available_count_hint(controller.ws.availableProjectsCount)} ${loc.project_plural_genitive(controller.ws.availableProjectsCount)}';

  Widget? get _bottomBar => controller.selectedSource != null && _hasProjects
      ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          LightText(
            _importActionHint,
            color: _validated ? null : warningColor,
            align: TextAlign.center,
          ),
          const SizedBox(height: P_2),
          MTLimitBadge(
            child: MTButton.main(
              titleText: '${loc.import_action_title}$_importBtnCountHint',
              onTap: _validated ? controller.startImport : null,
            ),
            showBadge: controller.selectableCount < 0,
          ),
        ])
      : controller.ws.sources.isEmpty
          ? MTButton.main(
              leading: const PlusIcon(color: lightBackgroundColor),
              titleText: loc.source_title_new,
              onTap: () => startAddSource(controller.ws),
            )
          : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          middle: controller.ws.subPageTitle(loc.import_title),
          bgColor: backgroundColor,
        ),
        body: SafeArea(bottom: false, child: _body),
        bottomBar: _bottomBar,
      ),
    );
  }
}
