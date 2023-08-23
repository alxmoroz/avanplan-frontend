// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/member.dart';
import '../components/colors_base.dart';
import '../components/constants.dart';
import '../components/text_widgets.dart';
import 'person.dart';

extension MemberPresenter on Member {
  Widget iconName({double radius = P, BorderSide? borderSide, Color? color}) {
    final textColor = color ?? (isActive ? null : f2Color);
    return Row(
      children: [
        if (isActive) ...[
          PersonAvatar(this, radius, borderSide: borderSide),
          const SizedBox(width: P_2),
        ],
        NormalText('$this', color: textColor),
      ],
    );
  }
}
