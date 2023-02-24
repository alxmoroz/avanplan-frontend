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
import '../../usecases/task_ext_actions.dart';
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

  /// тип источника

  @observable
  String? selectedType;

  @action
  void selectType(String? _type) => selectedType = _type;

  /// источники импорта, трекеры

  @observable
  List<Source> sources = [];

  // TODO: здесь загружаем и проверяем трекеры на старте приложения (загружаем вместе в РП). Что не обязательно делать на старте.
  // Если тут сделать по запросу, тогда в окне импорта нужно будет учесть тоже

  @action
  Future fetchData() async {
    final _sources = <Source>[];
    for (Workspace ws in mainController.editableWSs) {
      _sources.addAll(ws.sources);
    }
    sources = _sources;
    _sortSources();
  }

  @action
  void clearData() => sources = [];

  /// выбранный трекер

  @observable
  int? selectedSourceId;

  @action
  void selectSource(Source? s) {
    selectedSourceId = s?.id;
    selectWS(s?.wsId);
  }

  Source? sourceForId(int? id) => sources.firstWhereOrNull((s) => s.id == id);

  @computed
  Source? get selectedSource => sourceForId(selectedSourceId);

  @computed
  bool get canEdit => selectedSource != null;

  @override
  bool get validated => super.validated && selectedType != null && selectedWS != null;

  @action
  Future<bool> checkSourceConnection(int? srcId) async {
    final index = sources.indexWhere((s) => s.id == srcId);
    bool connected = false;
    if (index >= 0) {
      final src = sources[index];
      try {
        if (src.id != null) {
          src.state = SrcState.unknown;
          // TODO: нужен способ дергать обсервер без этих хаков
          sources = [...sources];

          connected = await sourceUC.checkConnection(src);
          src.state = connected ? SrcState.connected : SrcState.error;
          sources = [...sources];
        }
      } on MTImportError {
        src.state = SrcState.error;
        sources = [...sources];
      }
    }
    return connected;
  }

  void checkSources() => sources.forEach((src) => checkSourceConnection(src.id));

  @action
  void _sortSources() => sources.sort((s1, s2) => s1.url.compareTo(s2.url));

  @action
  Future _updateSourceInList(Source? _s) async {
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
    }
  }

  /// действия

  Future save(BuildContext context) async {
    loaderController.start();
    loaderController.setSaving();
    final editedSource = await sourceUC.save(Source(
      id: selectedSource?.id,
      url: tfAnnoForCode('url').text,
      apiKey: tfAnnoForCode('apiKey').text,
      username: tfAnnoForCode('username').text,
      // password: tfAnnoForCode('password').text,
      description: tfAnnoForCode('description').text,
      wsId: selectedWS!.id!,
      type: selectedType!,
    ));

    if (editedSource != null) {
      Navigator.of(context).pop(editedSource);
      await loaderController.stop(300);
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
        loaderController.start();
        loaderController.setDeleting();
        Navigator.of(context).pop(await sourceUC.delete(selectedSource!));

        // отвязываем задачи
        mainController.rootTask.tasks.where((t) => t.taskSource?.sourceId == selectedSourceId).forEach((t) => t.unlinkTaskTree());
        mainController.updateRootTask();

        await loaderController.stop(300);
      }
    }
  }

  /// роутер

  Future<Source?> addSource({String? sType}) async => await editSource(sType: sType);

  Future<Source?> editSource({Source? src, String? sType}) async {
    selectSource(src);
    if (src == null && sType != null) {
      selectType(sType);
    }

    final _s = await editSourceDialog();
    if (_s != null) {
      await _updateSourceInList(_s);
      if (!_s.deleted) {
        checkSourceConnection(_s.id);
      }
    }
    return _s;
  }
}
