// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/remote_source.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/checkbox.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/dropdown.dart';
import '../../components/shadowed.dart';
import '../../components/toolbar.dart';
import '../../presenters/remote_source.dart';
import '../../presenters/workspace.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../../usecases/ws_sources.dart';
import '../_base/loader_screen.dart';
import '../app/services.dart';
import '../source/no_sources.dart';
import '../source/source_edit_dialog.dart';
import 'import_controller.dart';

// старт сценария по импорту задач
Future importTasks(Workspace ws) async {
  final ic = await ImportController().init(ws);
  ic.ws.checkSources();
  await showMTDialog(_ImportDialog(ic));
}

class _ImportDialog extends StatelessWidget {
  const _ImportDialog(this._ic);
  final ImportController _ic;

  bool get _hasProjects => _ic.projects.isNotEmpty;
  bool get _hasError => _ic.errorCode != null;
  bool get _validated => _ic.validated;
  bool get _selectedAll => _ic.selectedAll;
  bool get _sourceSelected => _ic.selectedSourceId != null;
  bool get _hasSources => _ic.ws.sources.isNotEmpty;
  bool get _showSelectAll => _ic.projects.length > 2;

  Widget get _sourceDropdown => MTDropdown<RemoteSource>(
        onChanged: _ic.selectSource,
        value: _ic.selectedSourceId,
        ddItems: [
          for (final s in _ic.ws.sortedSources)
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
              MTPlusButton(() async => await startAddSource(_ic.ws), type: MTButtonType.secondary),
            ],
          ),
          if (_sourceSelected) ...[
            const SizedBox(height: P2),
            if (_hasProjects) ...[
              if (_showSelectAll)
                MTCheckBoxTile(
                  title: '${loc.action_select_all_title} (${_ic.selectableProjects.length})',
                  titleColor: mainColor,
                  color: b2Color,
                  value: _selectedAll,
                  onChanged: _ic.toggleSelectedAll,
                ),
            ]
          ]
        ],
      );

  Widget _projectItemBuilder(BuildContext context, int index) {
    final project = _ic.projects[index];
    final value = project.selected;
    final importing = _ic.isImporting(project);
    return MTCheckBoxTile(
      title: project.title,
      description: importing ? loc.state_importing_label : null,
      value: value,
      bottomDivider: index < _ic.projects.length - 1,
      onChanged: importing ? null : (bool? value) => _ic.selectProject(project, value),
    );
  }

  Widget _body(BuildContext context) => _hasError
      ? ListView(
          shrinkWrap: true,
          children: [
            BaseText.medium(
              _hasError ? Intl.message(_ic.errorCode!) : loc.import_list_empty_title,
              align: TextAlign.center,
              color: _hasError ? dangerColor : f2Color,
            ),
          ],
        )
      : _hasSources
          ? MTShadowed(
              bottomShadow: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: _projectItemBuilder,
                itemCount: _ic.projects.length,
              ),
            )
          : NoSources(_ic.ws);

  String get _importBtnCountHint => _ic.selectedProjects.isNotEmpty ? ' (${_ic.selectedProjects.length})' : '';

  PreferredSizeWidget? _bottomBar(BuildContext context) => _hasProjects
      ? MTBottomBar(
          middle: MTButton.main(
            padding: const EdgeInsets.symmetric(horizontal: P3),
            titleText: '${loc.create_import_action_title}$_importBtnCountHint',
            onTap: _validated ? () => _ic.startImport(context) : null,
          ),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _ic.loading
          ? LoaderScreen(_ic, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(
                pageTitle: loc.import_title,
                parentPageTitle: _ic.ws.title,
                bottomWidget: _hasSources
                    ? PreferredSize(preferredSize: Size.fromHeight(P * 15 + (_showSelectAll ? DEF_BAR_HEIGHT : 0)), child: _header)
                    : null,
              ),
              body: _body(context),
              bottomBar: _bottomBar(context),
            ),
    );
  }
}
