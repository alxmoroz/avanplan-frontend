// Copyright (c) 2022. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../extra/services.dart';
import '../../views/_base/loadable.dart';

part 'template_controller.g.dart';

class TemplateController extends _TemplateControllerBase with _$TemplateController {
  TemplateController(int wsId) {
    setLoaderScreenLoading();
    _wsId = wsId;
  }
}

abstract class _TemplateControllerBase with Store, Loadable {
  late final int _wsId;

  @observable
  Iterable<Project> _templates = [];

  @action
  Future reload() async => load(() async => _templates = await wsTransferUC.getProjectTemplates(_wsId));

  @computed
  List<MapEntry<String, List<Project>>> get templatesGroups {
    final gt = groupBy<Project, String>(_templates, (t) => t.category ?? 'tmpl_category_universal');
    return gt.entries.sortedBy<String>((g) => g.key);
  }
}
