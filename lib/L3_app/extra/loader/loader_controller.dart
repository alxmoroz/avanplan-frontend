// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/text_widgets.dart';
import 'loader_screen.dart';

part 'loader_controller.g.dart';

class LoaderController extends _LoaderControllerBase with _$LoaderController {}

abstract class _LoaderControllerBase with Store {
  @observable
  Widget? iconWidget;

  @observable
  Widget? titleWidget;

  @observable
  Widget? descriptionWidget;

  @observable
  Widget? actionWidget;

  @observable
  BuildContext? _loaderContext;

  @action
  void setLoader(
    BuildContext? context, {
    String? titleText,
    Widget? title,
    String? descriptionText,
    Widget? description,
    Widget? icon,
    String? actionText,
    Widget? action,
  }) {
    iconWidget = icon ?? gerculesIcon();
    titleWidget = title ??
        (titleText != null
            ? H2(
                titleText,
                align: TextAlign.center,
                padding: EdgeInsets.symmetric(horizontal: onePadding).copyWith(top: onePadding),
              )
            : null);
    descriptionWidget = description ??
        (descriptionText != null
            ? NormalText(
                descriptionText,
                align: TextAlign.center,
                padding: EdgeInsets.symmetric(horizontal: onePadding).copyWith(top: onePadding / 2),
              )
            : null);

    actionWidget = action ??
        (actionText != null
            ? MTButton.outlined(
                titleText: actionText,
                margin: EdgeInsets.symmetric(horizontal: onePadding),
                onTap: hideLoader,
              )
            : null);

    if (_loaderContext == null && context != null) {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          useSafeArea: false,
          builder: (BuildContext context) {
            _loaderContext = context;
            return LoaderScreen();
          });
    }
  }

  @action
  void hideLoader() {
    if (_loaderContext != null) {
      Navigator.of(_loaderContext!).pop();
      _loaderContext = null;
    }
  }
}
