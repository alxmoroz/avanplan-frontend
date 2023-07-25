// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'icons.dart';
import 'mt_button.dart';

class MTCloseDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MTButton.icon(
        const CloseIcon(),
        onTap: () => Navigator.of(context).pop(),
        padding: const EdgeInsets.all(P),
      );
}
