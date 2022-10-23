// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/mt_page.dart';
import '../../extra/services.dart';

class LoaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTPage(
          body: SafeArea(
            top: false,
            bottom: false,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (loaderController.iconWidget != null) loaderController.iconWidget!,
                  if (loaderController.titleWidget != null) loaderController.titleWidget!,
                  if (loaderController.descriptionWidget != null) loaderController.descriptionWidget!,
                  if (loaderController.actionWidget == null) ...[
                    const SizedBox(height: 20),
                    Row(children: const [
                      Spacer(),
                      CircularProgressIndicator(),
                      Spacer(),
                    ]),
                  ],
                ],
              ),
            ),
          ),
          bottomBar: loaderController.actionWidget,
        ),
      );
}
