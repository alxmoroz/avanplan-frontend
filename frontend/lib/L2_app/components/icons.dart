// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

Icon get chevronIcon => const Icon(CupertinoIcons.chevron_right, color: CupertinoColors.systemGrey);

Widget get crownPicture => SvgPicture.asset('assets/icons/crown.svg', height: 16, color: CupertinoColors.systemYellow);

Icon get dropdownIcon => const Icon(CupertinoIcons.chevron_up_chevron_down, color: CupertinoColors.systemBlue);

Icon get pencilIcon => const Icon(CupertinoIcons.pencil, color: CupertinoColors.systemBlue);

Icon get plusIcon => const Icon(CupertinoIcons.plus_circle, size: 28);

Icon get cloudIcon => const Icon(CupertinoIcons.cloud, size: 28);
