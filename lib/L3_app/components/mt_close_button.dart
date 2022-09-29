// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'icons.dart';
import 'mt_button.dart';

class MTCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MTButton.icon(
        closeIcon(context),
        () => Navigator.of(context).pop(),
        margin: EdgeInsets.all(onePadding),
      );
}
