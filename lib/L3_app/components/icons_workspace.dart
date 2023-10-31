// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'icons.dart';

class MemberAddIcon extends MTIcon {
  const MemberAddIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.person_add,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class PeopleIcon extends MTIcon {
  const PeopleIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.person_2,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class ProjectsIcon extends MTIcon {
  const ProjectsIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.briefcase,
        color: (color ?? f2Color).resolve(context),
        size: size ?? P6,
      );
}

class TasksIcon extends MTIcon {
  const TasksIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.text_badge_checkmark,
        color: (color ?? f2Color).resolve(context),
        size: size ?? P6,
      );
}

class RoubleIcon extends MTIcon {
  const RoubleIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.money_rubl,
        color: (color ?? f2Color).resolve(context),
        size: size,
      );
}

class RoubleCircleIcon extends MTIcon {
  const RoubleCircleIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.money_rubl_circle_fill,
        color: (color ?? warningColor).resolve(context),
        size: size ?? P4,
      );
}

class TariffIcon extends MTIcon {
  const TariffIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.creditcard,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class WSIconHome extends MTIcon {
  const WSIconHome({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.house_alt,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class WSIconPublic extends MTIcon {
  const WSIconPublic({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.building_2_fill,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}
