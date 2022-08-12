// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_circle.dart';
import '../../components/mt_divider.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
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
        ListTile(
          leading: Column(children: [
            sourceIcon(context, s),
            SizedBox(height: onePadding / 3),
            MTCircle(color: s.connected ? Colors.green : warningColor),
          ]),
          title: NormalText('${s.type.title} ${s.description}'),
          subtitle: SmallText(s.url),
          trailing: editIcon(context),
          minLeadingWidth: 0,
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: () => _controller.editSource(context, s),
        )
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
            ? EmptyDataWidget(
                title: loc.source_list_empty_title,
                addTitle: loc.source_title_new,
                onAdd: () => _controller.addSource(context),
              )
            : ListView.builder(
                itemBuilder: sourceBuilder,
                itemCount: _controller.sources.length,
              ),
      ),
    );
  }
}
