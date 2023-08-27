// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'text.dart';

class TextDemo extends StatelessWidget {
  Widget _t(BaseText text, BuildContext context) {
    final style = text.style(context);
    return Column(
      children: [
        Row(
          children: [
            text,
            const Spacer(),
            NormalText('size: ${style.fontSize?.round()}  weight: ${style.fontWeight?.value}'),
          ],
        ),
        const SizedBox(height: P2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _t(const D1('D1'), context),
        _t(const D2('D2'), context),
        _t(const D3('D3'), context),
        _t(const H1('H1'), context),
        _t(const H2('H2'), context),
        _t(const H3('H3'), context),
        _t(const MediumText('Medium'), context),
        _t(const NormalText('Normal'), context),
        _t(const LightText('LightText'), context),
        _t(const SmallText('SmallText'), context),
      ],
    );
  }
}
