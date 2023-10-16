// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'text.dart';

class ColorsDemo extends StatelessWidget {
  String _printColor(CupertinoDynamicColor cdColor) {
    final color = cdColor.color;
    final darkColor = cdColor.darkColor;
    return '  ${color.red}.${color.green}.${color.blue}\n  ${darkColor.red}.${darkColor.green}.${darkColor.blue}';
  }

  Widget get _fp1 => SmallText(_printColor(f1Color));
  Widget get _fp2 => SmallText(_printColor(f2Color));
  Widget get _fp3 => SmallText(_printColor(f3Color));
  Widget get _f1 => const H2(' F1', color: f1Color);
  Widget get _f2 => const H2(' F2', color: f2Color);
  Widget get _f3 => const H2(' F3  ', color: f3Color);
  Widget get _b1 => SmallText(_printColor(b1Color));
  Widget get _b2 => SmallText(_printColor(b2Color));
  Widget get _b3 => SmallText(_printColor(b3Color));

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(child: Row(children: [_fp1, _fp2, _fp3])),
        Container(color: b1Color.resolve(context), child: Row(children: [_f1, _f2, _f3, _b1])),
        Container(color: b2Color.resolve(context), child: Row(children: [_f1, _f2, _f3, _b2])),
        Container(color: b3Color.resolve(context), child: Row(children: [_f1, _f2, _f3, _b3])),
      ],
    );
  }
}
