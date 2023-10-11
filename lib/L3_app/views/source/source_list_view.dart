// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/adaptive.dart';
import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/page.dart';
import '../../components/shadowed.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_actions.dart';
import 'no_sources.dart';
import 'source_edit_view.dart';

class SourceListView extends StatelessWidget {
  const SourceListView(this._wsId);
  final int _wsId;

  static String get routeName => '/sources';
  static String title(int wsId) => '${wsMainController.wsForId(wsId)} - ${loc.source_list_title}';

  Workspace get _ws => wsMainController.wsForId(_wsId);

  Widget _sourceBuilder(BuildContext _, int index) {
    final s = _ws.sortedSources[index];
    return s.listTile(
      iconSize: P7,
      bottomBorder: index < _ws.sortedSources.length - 1,
      onTap: () => editSource(_ws, src: s),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(context, middle: _ws.subPageTitle(loc.source_list_title)),
        body: SafeArea(
          top: false,
          bottom: false,
          child: _ws.sources.isEmpty
              ? Center(child: NoSources())
              : MTShadowed(
                  child: MTAdaptive(
                    child: ListView.builder(
                      itemBuilder: _sourceBuilder,
                      itemCount: _ws.sources.length,
                    ),
                  ),
                ),
        ),
        bottomBar: _ws.hpSourceCreate
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_ws.sources.isNotEmpty) const Spacer(),
                  _ws.sources.isEmpty
                      ? MTButton.main(
                          leading: const PlusIcon(color: mainBtnTitleColor),
                          titleText: loc.source_title_new,
                          onTap: () => startAddSource(_ws),
                        )
                      : MTPlusButton(() => startAddSource(_ws))
                ],
              )
            : null,
      ),
    );
  }
}
