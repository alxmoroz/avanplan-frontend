// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/member.dart';
import '../components/colors_base.dart';
import '../components/constants.dart';
import '../components/text.dart';
import 'person.dart';

extension MemberPresenter on Member {
  Widget iconName({double radius = P2, Color? borderColor, Color? color}) {
    final textColor = color ?? (isActive ? null : f2Color);
    return Row(
      children: [
        if (isActive) ...[
          icon(radius, borderColor: borderColor),
          const SizedBox(width: P),
        ],
        Expanded(
          child: BaseText('$this', color: textColor, maxLines: 1),
        ),
      ],
    );
  }
}
