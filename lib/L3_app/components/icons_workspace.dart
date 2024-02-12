// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors_base.dart';
import 'constants.dart';
import 'icons.dart';

class PeopleIcon extends MTIcon {
  const PeopleIcon({super.key, super.color, super.size}) : super(CupertinoIcons.person_2);
}

class ProjectsIcon extends MTIcon {
  const ProjectsIcon({super.key, super.color = f2Color, super.size = P6}) : super(CupertinoIcons.folder);
}

class TariffIcon extends MTIcon {
  const TariffIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.creditcard);
}

class WSIconHome extends MTIcon {
  const WSIconHome({super.key, super.color, super.size = P6}) : super(CupertinoIcons.house_alt);
}

class WSIconPublic extends MTIcon {
  const WSIconPublic({super.key, super.color, super.size = P6}) : super(CupertinoIcons.building_2_fill);
}
