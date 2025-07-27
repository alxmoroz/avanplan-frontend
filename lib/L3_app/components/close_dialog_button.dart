// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../theme/colors.dart';
import 'button.dart';
import 'constants.dart';
import 'icons.dart';

class MTCloseDialogButton extends StatelessWidget {
  const MTCloseDialogButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => MTButton.icon(
        const CloseIcon(color: f3Color),
        onTap: onTap ?? () => Navigator.of(context).pop(),
        padding: const EdgeInsets.all(P2),
      );
}
