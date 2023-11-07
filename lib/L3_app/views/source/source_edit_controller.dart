// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/source_type.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_sources.dart';
import '../../../main.dart';
import '../../components/alert_dialog.dart';
import '../../components/constants.dart';
import '../../components/field_data.dart';
import '../../components/text_field.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';
import '../../usecases/task_link.dart';
import '../_base/edit_controller.dart';

part 'source_edit_controller.g.dart';

enum SourceFCode { url, username, apiKey, password, description }

class SourceEditController extends _SourceEditControllerBase with _$SourceEditController {
  SourceEditController(Workspace _ws, int? _srcId, SourceType? sType) {
    ws = _ws;
    srcId = _srcId;
    selectType(source?.type ?? sType);

    final isTrello = selectedType?.isTrello == true;
    final isTrelloJson = selectedType?.isTrelloJson == true;

    initState(fds: [
      MTFieldData(SourceFCode.url.index,
          label: loc.source_url_placeholder, text: source?.url ?? (isTrello ? 'https://api.trello.com' : ''), validate: isTrelloJson),
      MTFieldData(SourceFCode.username.index, label: loc.auth_user_placeholder, text: source?.username ?? '', validate: showUsername),
      MTFieldData(SourceFCode.apiKey.index, label: loc.source_api_key_placeholder, text: source?.apiKey ?? '', validate: !isTrelloJson),
      // MTFieldData(SourceFCode.password.index, label: loc.auth_password_placeholder),
      MTFieldData(SourceFCode.description.index, label: loc.description, text: source?.description ?? (isTrello ? 'Trello' : '')),
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
      Source(
        id: source?.id,
        url: fData(SourceFCode.url.index).text,
        apiKey: fData(SourceFCode.apiKey.index).text,
        username: fData(SourceFCode.username.index).text,
        // password: tfAnnoForCode(SourceFCode.password.index).text,
        description: fData(SourceFCode.description.index).text,
        typeCode: selectedType!.code,
        wsId: ws.id!,
      ),
    );

    if (editedSource != null) {
      Navigator.of(rootKey.currentContext!).pop(editedSource);
    }
    await loader.stop(300);
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
        Navigator.of(context).pop(await sourceUC.delete(source!));

        // отвязываем задачи
        tasksMainController.projects.where((p) => p.taskSource?.sourceId == source!.id).forEach((p) => p.unlinkTaskTree());
        tasksMainController.refreshTasks();

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
      suggestions: code == SourceFCode.description,
      autocorrect: code == SourceFCode.description,
      obscureText: code == SourceFCode.password,
      maxLines: 1,
      capitalization: TextCapitalization.none,
      margin: tfPadding.copyWith(top: first ? P : tfPadding.top),
    );
  }

  Future getTrelloToken() async {
    await launchUrlString(
        'https://trello.com/1/authorize?expiration=never&scope=account,read&response_type=token&key=5cbcf3719f220514a730154ebf5084ae');
  }
}
