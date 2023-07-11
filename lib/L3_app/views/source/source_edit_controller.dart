// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/source_type.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_ext.dart';
import '../../../main.dart';
import '../../components/constants.dart';
import '../../components/mt_alert_dialog.dart';
import '../../components/mt_field_data.dart';
import '../../components/mt_text_field.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import '../_base/edit_controller.dart';

part 'source_edit_controller.g.dart';

enum SourceFCode { url, username, apiKey, password, description }

class SourceEditController extends _SourceEditControllerBase with _$SourceEditController {
  SourceEditController(Workspace _ws, int? _srcId, SourceType? sType) {
    ws = _ws;
    srcId = _srcId;
    selectType(source?.type ?? sType);

    final isTrello = selectedType?.isTrello == true;

    initState(fds: [
      MTFieldData(
        SourceFCode.url.index,
        label: loc.source_url_placeholder,
        text: source?.url ?? (isTrello ? 'https://api.trello.com' : ''),
      ),
      MTFieldData(SourceFCode.username.index, label: loc.auth_user_placeholder, text: source?.username ?? '', needValidate: showUsername),
      MTFieldData(SourceFCode.apiKey.index, label: loc.source_api_key_placeholder, text: source?.apiKey ?? ''),
      // TFAnnotation(SourceFCode.password.index, label: loc.auth_password_placeholder, needValidate: false),
      MTFieldData(
        SourceFCode.description.index,
        label: loc.description,
        text: source?.description ?? (isTrello ? 'Trello' : ''),
        needValidate: false,
      ),
    ]);
  }
}

abstract class _SourceEditControllerBase extends EditController with Store {
  late final Workspace ws;
  late final int? srcId;

  Source? get source => ws.sourceForId(srcId);

  @computed
  bool get canEdit => source != null;

  /// тип источника

  @observable
  SourceType? selectedType;

  @action
  void selectType(SourceType? _type) => selectedType = _type;

  @computed
  bool get showUsername => selectedType?.isJira == true;

  @computed
  bool get showUrl => selectedType?.isTrello == false;

  @override
  bool get validated => super.validated && selectedType != null;

  /// действия

  Future save() async {
    loader.start();
    loader.setSaving();
    final editedSource = await sourceUC.save(
        ws,
        Source(
          id: source?.id,
          url: fData(SourceFCode.url.index).text,
          apiKey: fData(SourceFCode.apiKey.index).text,
          username: fData(SourceFCode.username.index).text,
          // password: tfAnnoForCode(SourceFCode.password.index).text,
          description: fData(SourceFCode.description.index).text,
          typeCode: selectedType!.code,
        ));

    if (editedSource != null) {
      Navigator.of(rootKey.currentContext!).pop(editedSource);
      await loader.stop(300);
    }
  }

  Future delete(BuildContext context) async {
    if (canEdit) {
      final confirm = await showMTAlertDialog(
        loc.source_delete_dialog_title,
        description: '${loc.source_delete_dialog_description}\n\n${loc.delete_dialog_description}',
        actions: [
          MTADialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
          MTADialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
        ],
        simple: true,
      );
      if (confirm == true) {
        loader.start();
        loader.setDeleting();
        Navigator.of(context).pop(await sourceUC.delete(ws, source!));

        // отвязываем задачи
        mainController.rootTask.tasks.where((t) => t.taskSource?.sourceId == source!.id).forEach((t) => t.unlinkTaskTree());
        mainController.updateRootTask();

        await loader.stop(300);
      }
    }
  }

  Widget tf(SourceFCode code, {bool first = false}) {
    final fd = fData(code.index);
    return MTTextField(
      controller: teController(code.index),
      label: fd.label,
      error: fd.errorText,
      obscureText: code == SourceFCode.password,
      maxLines: 1,
      capitalization: TextCapitalization.none,
      margin: tfPadding.copyWith(top: first ? P_2 : tfPadding.top),
    );
  }

  Future getTrelloToken() async {
    await launchUrlString(
        'https://trello.com/1/authorize?expiration=never&scope=account,read&response_type=token&key=5cbcf3719f220514a730154ebf5084ae');
  }
}
