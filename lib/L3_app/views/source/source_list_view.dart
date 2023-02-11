// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_card.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import 'source_add_menu.dart';
import 'source_controller.dart';

class SourceListView extends StatelessWidget {
  static String get routeName => '/sources';

  SourceController get _controller => sourceController;

  Widget _sourceBuilder(BuildContext context, int index) {
    final s = _controller.sources[index];
    return MTCardButton(child: s.info(context), onTap: () => _controller.editSource(src: s));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, title: loc.source_list_title),
        body: SafeArea(
          top: false,
          bottom: false,
          child: _controller.sources.isEmpty
              ? Center(child: H4(loc.source_list_empty_title, align: TextAlign.center, color: lightGreyColor))
              : ListView.builder(
                  itemBuilder: (_, int index) => _sourceBuilder(context, index),
                  itemCount: _controller.sources.length,
                ),
        ),
        bottomBar: mainController.canEditAnyWS
            ? Row(children: [
                Expanded(
                  child: _controller.sources.isEmpty ? SourceAddMenu(title: loc.source_title_new, margin: const EdgeInsets.all(P)) : const SizedBox(),
                ),
                if (_controller.sources.isNotEmpty) const SourceAddMenu(margin: EdgeInsets.all(P)),
              ])
            : null,
      ),
    );
  }
}
