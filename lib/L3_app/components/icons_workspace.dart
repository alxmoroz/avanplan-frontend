// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'icons.dart';

class PeopleIcon extends MTIcon {
  const PeopleIcon({super.key, super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.person_2,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class ProjectsIcon extends MTIcon {
  const ProjectsIcon({super.key, super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.folder,
        color: (color ?? f2Color).resolve(context),
        size: size ?? P6,
      );
}

class TariffIcon extends MTIcon {
  const TariffIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.creditcard,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class WSIconHome extends MTIcon {
  const WSIconHome({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.house_alt,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class WSIconPublic extends MTIcon {
  const WSIconPublic({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.building_2_fill,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}
