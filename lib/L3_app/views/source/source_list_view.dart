// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_source_presenter.dart';
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
    return MTListTile(
      middle: s.info(context),
      trailing: editIcon(context),
      onTap: () => _controller.editSource(context, src: s),
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
          trailing: MTButton.icon(plusIcon(context), () => _controller.addSource(context), margin: EdgeInsets.only(right: onePadding)),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: _controller.sources.isEmpty
              ? Center(
                  child: ListView(shrinkWrap: true, children: [
                  MediumText(loc.source_list_empty_title, align: TextAlign.center, color: lightGreyColor),
                  MTButton.outlined(
                    margin: EdgeInsets.all(onePadding),
                    titleString: loc.source_title_new,
                    leading: plusIcon(context),
                    onTap: () => _controller.addSource(context),
                  )
                ]))
              : ListView.builder(
                  itemBuilder: sourceBuilder,
                  itemCount: _controller.sources.length,
                ),
        ),
      ),
    );
  }
}
