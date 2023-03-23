// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_ext.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../../usecases/task_ext_actions.dart';
import '../_base/edit_controller.dart';

part 'source_edit_controller.g.dart';

class SourceEditController extends _SourceEditControllerBase with _$SourceEditController {
  SourceEditController(int? _srcId, String? sType) {
    srcId = _srcId;
    selectType(source?.type ?? sType);

    initState(tfaList: [
      TFAnnotation('url', label: loc.source_url_placeholder, text: source?.url ?? ''),
      TFAnnotation('username', label: loc.auth_user_placeholder, text: source?.username ?? '', needValidate: showUsername),
      TFAnnotation('apiKey', label: loc.source_api_key_placeholder, text: source?.apiKey ?? ''),
      // TFAnnotation('password', label: loc.auth_password_placeholder, needValidate: false),
      TFAnnotation('description', label: loc.description, text: source?.description ?? '', needValidate: false),
    ]);
  }
}

abstract class _SourceEditControllerBase extends EditController with Store {
  int? srcId;

  Workspace get ws => mainController.selectedWS!;
  Source? get source => ws.sourceForId(srcId);

  @computed
  bool get canEdit => source != null;

  /// тип источника

  @observable
  String? selectedType;

  @action
  void selectType(String? _type) => selectedType = _type;

  @computed
  bool get showUsername => selectedType == 'Jira';

  @override
  bool get validated => super.validated && selectedType != null;

  /// действия

  Future save(BuildContext context) async {
    loaderController.start();
    loaderController.setSaving();
    final editedSource = await sourceUC.save(Source(
      id: source?.id,
      url: tfAnnoForCode('url').text,
      apiKey: tfAnnoForCode('apiKey').text,
      username: tfAnnoForCode('username').text,
      // password: tfAnnoForCode('password').text,
      description: tfAnnoForCode('description').text,
      wsId: mainController.selectedWS!.id!,
      type: selectedType!,
    ));

    if (editedSource != null) {
      Navigator.of(context).pop(editedSource);
      await loaderController.stop(300);
    }
  }

  Future delete(BuildContext context) async {
    if (canEdit) {
      final confirm = await showMTDialog(
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
        Navigator.of(context).pop(await sourceUC.delete(source!));

        // отвязываем задачи
        mainController.rootTask.tasks.where((t) => t.taskSource?.sourceId == source!.id).forEach((t) => t.unlinkTaskTree());
        mainController.updateRootTask();

        await loaderController.stop(300);
      }
    }
  }
}
