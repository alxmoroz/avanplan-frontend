// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors_base.dart';
import 'constants.dart';
import 'icons.dart';

class BankCardIcon extends MTIcon {
  const BankCardIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.creditcard);
}

class PeopleIcon extends MTIcon {
  const PeopleIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.person_2);
}

class ProjectsIcon extends MTIcon {
  const ProjectsIcon({super.key, super.color = f2Color, super.size = P6}) : super(CupertinoIcons.folder);
}

class WSHomeIcon extends MTIcon {
  const WSHomeIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.house_alt);
}

class WSPublicIcon extends MTIcon {
  const WSPublicIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.building_2_fill);
}
