// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_action.dart';
import '../../components/mt_button.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import 'source_controller.dart';

class SourceListView extends StatefulWidget {
  static String get routeName => 'source_list';

  @override
  _SourceListViewState createState() => _SourceListViewState();
}

class _SourceListViewState extends State<SourceListView> {
  SourceController get _controller => sourceController;

  Widget sourceBuilder(BuildContext _, int index) {
    final s = _controller.sources[index];
    return Column(
      children: [
        if (index > 0) const MTDivider(),
        MTButton(
          '',
          () => _controller.editSource(context, s),
          padding: EdgeInsets.symmetric(horizontal: onePadding, vertical: onePadding / 2),
          child: Row(children: [
            Expanded(child: sourceInfo(context, s)),
            editIcon(context),
          ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(
          context,
          title: loc.source_list_title,
          trailing: MTButton.icon(plusIcon(context), () => _controller.addSource(context), padding: EdgeInsets.only(right: onePadding)),
        ),
        body: _controller.sources.isEmpty
            ? MTAction(
                hint: loc.source_list_empty_title,
                title: loc.source_title_new,
                icon: plusIcon(context, size: 24),
                onPressed: () => _controller.addSource(context),
              )
            : ListView.builder(
                itemBuilder: sourceBuilder,
                itemCount: _controller.sources.length,
              ),
      ),
    );
  }
}
