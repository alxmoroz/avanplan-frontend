// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/source_type.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_sources.dart';
import '../../components/alert_dialog.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/field_data.dart';
import '../../components/text_field.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';
import '../../usecases/ws_actions.dart';
import '../../views/task/usecases/link.dart';
import '../_base/edit_controller.dart';
import '../_base/loadable.dart';

part 'source_edit_controller.g.dart';

enum SourceFCode { url, username, apiKey, password, description }

class SourceEditController extends _SourceEditControllerBase with _$SourceEditController {
  SourceEditController(Workspace wsIn, int? srcIdIn, SourceType? sType) {
    ws = wsIn;
    srcId = srcIdIn;
    selectType(source?.type ?? sType);

    final isTrello = selectedType?.isTrello == true;
    final isJson = selectedType?.isJson == true;
    final hasApiKey = selectedType?.hasApiKey == true;

    initState(fds: [
      MTFieldData(SourceFCode.url.index,
          label: loc.source_url_placeholder, text: source?.url ?? (isTrello ? 'https://api.trello.com' : ''), validate: isJson),
      MTFieldData(SourceFCode.username.index, label: loc.source_auth_user_placeholder, text: source?.username ?? '', validate: showUsername),
      if (hasApiKey) MTFieldData(SourceFCode.apiKey.index, label: loc.source_api_key_placeholder, text: source?.apiKey ?? '', validate: hasApiKey),
      // MTFieldData(SourceFCode.password.index, label: loc.auth_password_placeholder),
      MTFieldData(SourceFCode.description.index, label: loc.description, text: source?.description ?? (isTrello ? 'Trello' : '')),
    ]);
  }
}

abstract class _SourceEditControllerBase extends EditController with Store, Loadable {
  late final Workspace ws;
  late final int? srcId;

  Source? get source => ws.sourceForId(srcId);

  @computed
  bool get canEdit => source != null;

  /// тип источника

  @observable
  SourceType? selectedType;

  @action
  void selectType(SourceType? type) => selectedType = type;

  @computed
  bool get showUsername => selectedType?.isJira == true;

  @computed
  bool get showUrl => selectedType?.isTrello == false;

  @override
  bool get validated => super.validated && selectedType != null;

  /// действия

  Future save(BuildContext context) async {
    if (await ws.checkBalance(loc.source_create_action_title)) {
      setLoaderScreenSaving();
      load(() async {
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
        if (editedSource != null && context.mounted) Navigator.of(context).pop(editedSource);
      });
    }
  }

  Future delete(BuildContext context) async {
    if (canEdit) {
      if (await showMTAlertDialog(
            loc.source_delete_dialog_title,
            description: '${loc.source_delete_dialog_description}\n\n${loc.delete_dialog_description}',
            actions: [
              MTDialogAction(title: loc.yes, type: ButtonType.danger, result: true),
              MTDialogAction(title: loc.no, result: false),
            ],
          ) ==
          true) {
        setLoaderScreenDeleting();
        load(() async {
          final s = await sourceUC.delete(source!);
          if (s != null) {
            if (context.mounted) Navigator.of(context).pop(s);
            // отвязываем задачи
            tasksMainController.projects.where((p) => p.taskSource?.sourceId == source!.id).forEach((p) => p.unlinkTaskTree());
            tasksMainController.refreshUI();
          }
        });
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
