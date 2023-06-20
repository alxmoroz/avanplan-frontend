// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/images.dart';
import '../../components/mt_adaptive.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class LoaderScreen extends StatelessWidget {
  static const double _ldrIconSize = P * 16;

  Widget get _title => H2(
        loader.titleText!,
        align: TextAlign.center,
        padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
      );

  Widget get _description => H3(
        loader.descriptionText!,
        align: TextAlign.center,
        padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P),
        maxLines: 5,
      );

  Widget get _image => MTImage(loader.imageName!, size: _ldrIconSize);

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
                    const SizedBox(height: P3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: P * 5,
                          width: P * 5,
                          child: CircularProgressIndicator(color: mainColor.resolve(context)),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          bottomBar: MTAdaptive.S(loader.actionWidget),
        ),
      );
}
