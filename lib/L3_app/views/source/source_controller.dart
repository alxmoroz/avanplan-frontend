// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/workspace.dart';
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
    selectType(selectedSource?.type);
  }

  /// тип трекера

  @observable
  ObservableList<SourceType> sTypes = ObservableList();

  // TODO: здесь загружаем и проверяем трекеры на старте приложения (загружаем вместе в РП). Что не обязательно делать на старте.
  // Если тут сделать по запросу, тогда в окне импорта нужно будет учесть тоже

  @action
  Future fetchData() async {
    // startLoading();
    clearData();
    for (Workspace ws in mainController.workspaces) {
      sources.addAll(ws.sources);
    }
    _sortAndCheckSources();

    final _sTypes = await sourceTypesUC.getAll();
    _sTypes.sort((s1, s2) => s1.title.compareTo(s2.title));
    sTypes = ObservableList.of(_sTypes);
    // stopLoading();
  }

  @action
  void clearData() => sources.clear();

  @observable
  int? selectedTypeId;

  @action
  void selectType(SourceType? _type) => selectedTypeId = _type?.id;

  @computed
  SourceType? get selectedType => sTypes.firstWhereOrNull((s) => s.id == selectedTypeId);

  @override
  bool get isLoading => super.isLoading || mainController.isLoading;

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
  Future _sortAndCheckSources() async {
    for (int i = 0; i < sources.length; i++) {
      bool connected = false;
      final id = sources[i].id;
      try {
        if (id != null) {
          connected = (await importUC.getRootTasks(id)).isNotEmpty;
        }
      } catch (_) {}
      sources[i].connected = connected;
    }
    sources.sort((s1, s2) => s1.url.compareTo(s2.url));
    sources = ObservableList.of(sources);
  }

  @action
  void _updateSourceInList(Source? _s) {
    if (_s != null) {
      startLoading();
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
      _sortAndCheckSources();
      stopLoading();
    }
  }

  /// действия

  Future save(BuildContext context) async {
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

    if (editedSource != null) {
      Navigator.of(context).pop(editedSource);
    }
  }

  Future delete(BuildContext context) async {
    if (canEdit) {
      final confirm = await showMTDialog<bool?>(
        context,
        title: loc.source_delete_dialog_title,
        description: '${loc.source_delete_dialog_description}\n\n${loc.common_delete_dialog_description}',
        actions: [
          MTDialogAction(title: loc.common_yes, isDestructive: true, result: true),
          MTDialogAction(title: loc.common_no, isDefault: true, result: false),
        ],
      );
      if (confirm != null && confirm) {
        Navigator.of(context).pop(await sourcesUC.delete(s: selectedSource!));
      }
    }
  }

  /// роутер

  Future addSource(BuildContext context) async {
    await editSource(context, null);
  }

  Future editSource(BuildContext context, Source? rt) async {
    selectSource(rt);
    final s = await showEditSourceDialog(context);
    if (s != null) {
      _updateSourceInList(s);
      if (s.deleted) {
        Navigator.of(context).pop();
      }
    }
  }
}
