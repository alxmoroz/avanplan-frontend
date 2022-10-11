// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_card.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_source_presenter.dart';
import 'source_controller.dart';

class SourceListView extends StatelessWidget {
  static String get routeName => 'source_list';

  SourceController get _controller => sourceController;

  Widget _sourceBuilder(BuildContext context, int index) {
    final s = _controller.sources[index];
    return MTCard(
      child: s.info(context),
      onTap: () => _controller.editSource(context, src: s),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
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
                  child: _controller.sources.isEmpty
                      ? MTButton.outlined(
                          margin: EdgeInsets.all(onePadding),
                          titleString: loc.source_title_new,
                          leading: plusIcon(context),
                          onTap: () => _controller.addSource(context),
                        )
                      : const SizedBox(),
                ),
                MTPlusButton(() => _controller.addSource(context)),
              ])
            : null,
      ),
    );
  }
}
