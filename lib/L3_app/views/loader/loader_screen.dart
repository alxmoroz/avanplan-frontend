// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/images.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/services.dart';

class LoaderScreen extends StatelessWidget {
  Widget get _title => H3(
        loader.titleText!,
        align: TextAlign.center,
        padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P3),
      );

  Widget get _description => BaseText(
        loader.descriptionText!,
        align: TextAlign.center,
        padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P3),
        maxLines: 5,
      );

  Widget get _image => MTImage(loader.imageName!);

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
                  if (loader.imageName != null) _image,
                  if (loader.titleText != null) _title,
                  if (loader.descriptionText != null) _description,
                  if (loader.actionWidget == null) ...[
                    const SizedBox(height: P6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: P10,
                          width: P10,
                          child: CircularProgressIndicator(color: mainColor.resolve(context)),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          bottomBar: loader.actionWidget != null ? MTAdaptive.XS(child: loader.actionWidget) : null,
        ),
      );
}
