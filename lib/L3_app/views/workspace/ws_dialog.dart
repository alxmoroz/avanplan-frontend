// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/invoice.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/bytes.dart';
import '../../presenters/date.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_actions.dart';
import '../../usecases/ws_sources.dart';
import '../_base/loader_screen.dart';
import '../iap/iap_dialog.dart';
import '../tariff/tariff_dialog.dart';
import 'ws_controller.dart';
import 'ws_edit_dialog.dart';

class WSDialog extends StatefulWidget {
  const WSDialog(this._controller, {super.key});
  final WSController _controller;

  @override
  State<WSDialog> createState() => _WSDialogState();
}

class _WSDialogState extends State<WSDialog> {
  WSController get controller => widget._controller;
  Workspace get ws => controller.ws;
  Workspace get wsd => controller.wsDescriptor;

  Invoice get _invoice => ws.invoice;

  @override
  void initState() {
    if (!wsd.filled) controller.reload();

    super.initState();
  }

  // TODO: deprecated TASKS_COUNT, FS_VOLUME как только не останется старых тарифов
  num get _consumedTasks => _invoice.consumed(TOCode.TASKS) + _invoice.consumed("TASKS_COUNT");
  num get _consumedFileStorage => _invoice.consumed(TOCode.FILE_STORAGE) + _invoice.consumed('FS_VOLUME');

  Widget get _header => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(child: H2(ws.title, maxLines: 1)),
                if (ws.codeStr.isNotEmpty) H3(' ${ws.codeStr}', color: f3Color, maxLines: 1),
              ],
            ),
            if (ws.description.isNotEmpty)
              BaseText.f2(
                ws.description,
                maxLines: 3,
                padding: const EdgeInsets.only(top: P),
                align: TextAlign.center,
              ),
          ],
        ),
      );

  Widget get _balanceCard => MTAdaptive.xxs(
        child: MTCardButton(
          margin: const EdgeInsets.only(top: P3),
          onTap: () => replenishBalanceDialog(controller),
          child: Column(
            children: [
              BaseText.f2(loc.balance_amount_title),
              const SizedBox(height: P2),
              MTPrice(ws.balance, color: ws.balance < 0 ? warningColor : mainColor),
              const SizedBox(height: P2),
              BaseText.medium(loc.balance_replenish_action_title, color: mainColor),
            ],
          ),
        ),
      );

  Widget get _tariffRow => MTListTile(
        leading: const StarIcon(),
        titleText: _invoice.tariff.title,
        subtitle: SmallText(
          '${loc.contract_effective_date_title.toLowerCase()} ${_invoice.contract.createdOn.strMedium}',
          maxLines: 1,
        ),
        trailing: const ChevronIcon(),
        bottomDivider: false,
        onTap: () async => await showTariff(controller),
      );

  Widget get _wsMembers {
    final membersCountMoreStr = ws.membersCountMoreStr;
    return MTListTile(
      leading: const PeopleIcon(),
      middle: Row(
        children: [
          BaseText('${ws.users.length}', maxLines: 1),
          BaseText.f2(' ${loc.member_plural(ws.users.length)}', maxLines: 1),
        ],
      ),
      subtitle: Row(children: [
        Flexible(child: SmallText(ws.membersStr, maxLines: 1)),
        if (membersCountMoreStr.isNotEmpty)
          SmallText(
            membersCountMoreStr,
            maxLines: 1,
            padding: const EdgeInsets.only(left: P),
          )
      ]),
      trailing: const ChevronIcon(),
      bottomDivider: _consumedTasks > 0 || _consumedFileStorage > 0 || ws.hpSourceCreate,
      dividerIndent: P11,
      onTap: () => router.goWSUsers(wsd.id!),
    );
  }

  Widget get _tasks => MTListTile(
        leading: const TasksIcon(),
        middle: Row(
          children: [
            BaseText(_consumedTasks.humanValueStr, maxLines: 1),
            BaseText.f2(' ${loc.task_plural(_consumedTasks)}', maxLines: 1),
          ],
        ),
        trailing: const SizedBox(width: P3),
        dividerIndent: P11,
        bottomDivider: _consumedFileStorage > 0 || ws.hpSourceCreate,
      );

  Widget get _storage => MTListTile(
        leading: const FileStorageIcon(),
        middle: Row(
          children: [
            BaseText(_consumedFileStorage.humanBytesStr, maxLines: 1),
            BaseText.f2(' ${loc.tariff_option_file_storage_suffix}', maxLines: 1),
          ],
        ),
        trailing: const SizedBox(width: P3),
        dividerIndent: P11,
        bottomDivider: ws.hpSourceCreate,
      );

  Widget get _sources => MTListTile(
      leading: const ImportIcon(),
      titleText: '${loc.source_list_title} ${ws.sources.isNotEmpty ? '(${ws.sources.length})' : ''}',
      trailing: const ChevronIcon(),
      bottomDivider: false,
      onTap: () {
        ws.checkSources();
        router.goWSSources(wsd.id!);
      });

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return controller.loading && !ws.filled
          ? LoaderScreen(controller, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                  showCloseButton: true,
                  color: b2Color,
                  title: loc.workspace_title,
                  trailing: ws.hpInfoUpdate
                      ? MTButton.icon(
                          const EditIcon(),
                          onTap: () => editWS(controller),
                          margin: const EdgeInsets.only(right: P2),
                        )
                      : null),
              body: ListView(
                shrinkWrap: true,
                children: [
                  _header,
                  _balanceCard,
                  const SizedBox(height: P3),
                  _tariffRow,
                  const SizedBox(height: P3),
                  if (ws.hpMemberRead) _wsMembers,
                  _tasks,
                  _storage,
                  if (ws.hpSourceCreate) _sources,
                ],
              ),
            );
    });
  }
}
