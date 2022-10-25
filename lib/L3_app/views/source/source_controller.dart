// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/system/errors.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../workspace/workspace_bounded.dart';
import 'source_edit_view.dart';

part 'source_controller.g.dart';

class SourceController extends _SourceControllerBase with _$SourceController {}

abstract class _SourceControllerBase extends WorkspaceBounded with Store {
  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    if (selectedSource != null) {
      selectType(selectedSource?.type);
    }
  }

  // TODO: здесь загружаем и проверяем трекеры на старте приложения (загружаем вместе в РП). Что не обязательно делать на старте.
  // Если тут сделать по запросу, тогда в окне импорта нужно будет учесть тоже

  @action
  Future fetchData(BuildContext? context) async {
    final _sources = <Source>[];
    for (Workspace ws in mainController.selectableWSs) {
      _sources.addAll(ws.sources);
    }
    sources = ObservableList.of(_sources);
    _sortSources();
  }

  @action
  void clearData() {
    sources.clear();
  }

  @observable
  int? selectedTypeId;

  @action
  void selectType(SourceType? _type) => selectedTypeId = _type?.id;

  @computed
  SourceType? get selectedType => referencesController.sourceTypes.firstWhereOrNull((s) => s.id == selectedTypeId);

  /// источники импорта, трекеры

  @observable
  ObservableList<Source> sources = ObservableList();

  /// выбранный трекер

  @observable
  int? selectedSourceId;

  @action
  void selectSource(Source? _rt) {
    selectedSourceId = _rt?.id;
    selectWS(_rt?.workspaceId);
  }

  @computed
  Source? get selectedSource => sources.firstWhereOrNull((g) => g.id == selectedSourceId);

  @computed
  bool get canEdit => selectedSource != null;

  @override
  bool get validated => super.validated && selectedType != null && selectedWS != null;

  @action
  Future _checkSources(BuildContext? context, List<Source> _sources) async {
    if (context != null) {
      loaderController.start(context);
    }
    for (int i = 0; i < _sources.length; i++) {
      final index = sources.indexWhere((s) => s.id == _sources[i].id);
      if (index >= 0) {
        try {
          loaderController.set(titleText: 'Check source connection...\n${sources[index].type.title}');
          final id = sources[index].id;
          if (id != null) {
            sources[index].state = (await importUC.getRootTasks(id)).isNotEmpty ? SrcState.connected : SrcState.error;
          }
        } on MTImportError {
          sources[index].state = SrcState.error;
        }

        print(sources[index].state);
      }
    }
    if (context != null) {
      loaderController.stop();
    }

    sources = ObservableList.of(sources);
  }

  @action
  void _sortSources() => sources.sort((s1, s2) => s1.url.compareTo(s2.url));

  @action
  Future _updateSourceInList(BuildContext context, Source? _s) async {
    if (_s != null) {
      final index = sources.indexWhere((s) => s.id == _s.id);
      if (index >= 0) {
        if (_s.deleted) {
          sources.remove(_s);
        } else {
          sources[index] = _s;
        }
      } else {
        sources.add(_s);
      }
      _sortSources();
      // await _checkSources(context, [_s]);
    }
  }

  /// действия

  Future save(BuildContext context) async {
    loaderController.start(context);
    loaderController.set(titleText: 'Saving...');
    final editedSource = await sourcesUC.save(Source(
      id: selectedSource?.id,
      url: tfAnnoForCode('url').text,
      apiKey: tfAnnoForCode('apiKey').text,
      login: tfAnnoForCode('login').text,
      // password: tfAnnoForCode('password').text,
      description: tfAnnoForCode('description').text,
      workspaceId: selectedWS!.id!,
      type: selectedType!,
    ));
    //TODO: не обязательно проверять все источники тут. Достаточно только того, который редактировали
    if (editedSource != null) {
      await _checkSources(null, [editedSource]);
    }
    loaderController.stop();

    if (editedSource != null) {
      Navigator.of(context).pop(editedSource);
    }
  }

  Future delete(BuildContext context) async {
    if (canEdit) {
      final confirm = await showMTDialog<bool?>(
        context,
        title: loc.source_delete_dialog_title,
        description: '${loc.source_delete_dialog_description}\n\n${loc.delete_dialog_description}',
        actions: [
          MTDialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
          MTDialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
        ],
        simple: true,
      );
      if (confirm == true) {
        loaderController.start(context);
        loaderController.set(titleText: 'Deleting...');
        Navigator.of(context).pop(await sourcesUC.delete(s: selectedSource!));
        loaderController.stop();
        await mainController.updateAll(context);
      }
    }
  }

  /// роутер

  Future<Source?> addSource(BuildContext context, {SourceType? sType}) async => await editSource(context, sType: sType);

  Future<Source?> editSource(BuildContext context, {Source? src, SourceType? sType}) async {
    selectSource(src);
    if (src == null && sType != null) {
      selectType(sType);
    }
    final _s = await editSourceDialog(context);
    if (_s != null) {
      await _updateSourceInList(context, _s);
    }
    return _s;
  }
}
