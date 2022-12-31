// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/mt_constrained.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class LoaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MTPage(
        navBar: navBar(context, leading: const SizedBox(), middle: H2(loc.app_title)),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Observer(
                  builder: (_) => Stack(
                    alignment: Alignment.center,
                    children: [
                      if (loaderController.iconWidget != null) loaderController.iconWidget!,
                      Column(
                        children: [
                          if (loaderController.titleWidget != null) loaderController.titleWidget!,
                          if (loaderController.descriptionWidget != null) loaderController.descriptionWidget!,
                          if (loaderController.actionWidget == null) ...[
                            const SizedBox(height: 20),
                            Row(children: [
                              const Spacer(),
                              CircularProgressIndicator(color: greyColor.resolve(context)),
                              const Spacer(),
                            ]),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomBar: Observer(builder: (_) => MTConstrained(loaderController.actionWidget)),
      );
}
