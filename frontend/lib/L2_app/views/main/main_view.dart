// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../extra/services.dart';
import '../../components/divider.dart';
import '../../components/icons.dart';
import '../../components/material_wrapper.dart';
import '../../components/navbar.dart';
import '../../components/text/text_widgets.dart';

class MainView extends StatefulWidget {
  static String get routeName => 'main';

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    mainController.initState(context);
    super.initState();
  }

  @override
  void dispose() {
    mainController.dispose();
    super.dispose();
  }

  Widget _buildItem(int index) {
    // final comparison = mainController.comparisons[index];
    // final item = BaseEntity();
    return Column(
      children: [
        if (index > 0) const CDivider(),
        material(
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                H3("Title"),
                // if (item.description.isNotEmpty) SmallText(item.description),
                const SizedBox(height: 8),
              ],
            ),
            trailing: chevronIcon,
            onTap: () => null,
            dense: true,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Future refreshCallback() async {}

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: mQuery(Text(loc.appTitle), context),
            // leading: Button.icon(plusIcon, mainController.goToComparisonView, padding: const EdgeInsets.only(left: 20, right: 12, bottom: 8)),
            // trailing: Button.icon(cloudIcon, mainController.goToCloudView, padding: const EdgeInsets.only(left: 20, right: 12, bottom: 8)),
            padding: EdgeInsetsDirectional.zero,
          ),
          CupertinoSliverRefreshControl(
            builder: (_, mode, dy1, dy2, dy3) {
              Widget res = const SizedBox();
              res = material(
                Container(
                  height: dy1,
                  alignment: Alignment.center,
                  child: SmallText(packageInfo.version, align: TextAlign.center),
                ),
              );
              return res;
            },
            onRefresh: () async => refreshCallback,
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 12)),
          Observer(
            builder: (_) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => _buildItem(index),
                childCount: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
