// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
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
import '../../presenters/date.dart';
import '../../presenters/tariff.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_actions.dart';
import '../../usecases/ws_sources.dart';
import '../../usecases/ws_tariff.dart';
import '../iap/iap_view.dart';
import '../source/source_list_dialog.dart';
import '../user/user_list_dialog.dart';
import 'workspace_edit_view.dart';

class WorkspaceRouter extends MTRouter {
  int get _wsId => int.parse(rs!.uri.pathSegments.lastOrNull ?? '-1');

  static const _prefix = '/settings/workspaces';

  @override
  bool get isDialog => true;

  @override
  RegExp get pathRe => RegExp('^$_prefix/\\d+\$');

  @override
  Widget get page => WorkspaceDialog(_wsId);

  @override
  String get title => '${loc.workspace_title_short} ${wsMainController.ws(_wsId).code}';

  @override
  Future pushNamed(BuildContext context, {Object? args}) async => await Navigator.of(context).pushNamed('$_prefix/${args as int}');
}

class WorkspaceDialog extends StatelessWidget {
  const WorkspaceDialog(this._wsId, {super.key});
  final int _wsId;

  Workspace get _ws => wsMainController.ws(_wsId);

  Widget get _header => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(child: H2(_ws.title, maxLines: 1)),
                if (_ws.codeStr.isNotEmpty) H3(' ${_ws.codeStr}', color: f3Color, maxLines: 1),
              ],
            ),
            if (_ws.description.isNotEmpty)
              BaseText.f2(
                _ws.description,
                maxLines: 3,
                padding: const EdgeInsets.only(top: P),
                align: TextAlign.center,
              ),
          ],
        ),
      );

  Widget get _balance => MTAdaptive.xxs(
        child: MTCardButton(
          margin: const EdgeInsets.symmetric(vertical: P3),
          onTap: _ws.hpTariffUpdate ? () => replenishBalanceDialog(_wsId) : null,
          child: Column(
            children: [
              BaseText.f2(loc.balance_amount_title),
              const SizedBox(height: P2),
              MTCurrency(_ws.balance, color: _ws.balance < 0 ? warningColor : mainColor),
              const SizedBox(height: P2),
              if (_ws.hpTariffUpdate) BaseText.medium(loc.balance_replenish_action_title, color: mainColor),
            ],
          ),
        ),
      );

  Widget get _tariff => MTListTile(
        leading: const TariffIcon(),
        titleText: loc.tariff_title,
        subtitle: SmallText(
          '${_ws.invoice.tariff.title} (${loc.contract_effective_date_title.toLowerCase()} ${_ws.invoice.contract.createdOn.strMedium})',
          maxLines: 1,
        ),
        trailing: const ChevronIcon(),
        bottomDivider: false,
        onTap: () async => await _ws.changeTariff(),
      );

  Widget _users(BuildContext context) => MTListTile(
        leading: const PeopleIcon(size: P6),
        titleText: loc.user_list_title,
        subtitle: SmallText('${_ws.users.length} / ${_ws.maxUsers}', maxLines: 1),
        trailing: const ChevronIcon(),
        dividerIndent: P11,
        onTap: () async => await MTRouter.navigate(UsersRouter, context, args: _ws.id!),
      );

  Widget _sources(BuildContext context) => MTListTile(
      leading: const ImportIcon(),
      titleText: '${loc.source_list_title} ${_ws.sources.isNotEmpty ? '(${_ws.sources.length})' : ''}',
      trailing: const ChevronIcon(),
      bottomDivider: false,
      onTap: () async {
        _ws.checkSources();
        await MTRouter.navigate(SourcesRouter, context, args: _ws.id!);
      });

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTDialog(
        topBar: MTAppBar(
            showCloseButton: true,
            color: b2Color,
            title: loc.workspace_title,
            trailing: _ws.hpInfoUpdate
                ? MTButton.icon(
                    const EditIcon(),
                    onTap: () => editWSDialog(_ws),
                    margin: const EdgeInsets.only(right: P2),
                  )
                : null),
        body: ListView(
          shrinkWrap: true,
          children: [
            _header,
            _balance,
            _tariff,
            const SizedBox(height: P3),
            if (_ws.hpMemberRead) _users(context),
            if (_ws.hpSourceCreate) _sources(context),
          ],
        ),
      );
    });
  }
}
