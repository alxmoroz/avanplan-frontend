// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'icons.dart';
import 'mt_button.dart';

class CloseDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MTButton.icon(
        closeIcon(context),
        () => Navigator.of(context).pop(),
        padding: EdgeInsets.all(onePadding),
      );
}
