// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons.dart';

class BillingPeriodIcon extends MTIcon {
  const BillingPeriodIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_2_circlepath_circle,
        color: (color ?? lightGreyColor).resolve(context),
        size: size ?? P3,
      );
}

class MemberAddIcon extends MTIcon {
  const MemberAddIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.person_add,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class PeopleIcon extends MTIcon {
  const PeopleIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.person_2,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P2,
      );
}

class ProjectsIcon extends MTIcon {
  const ProjectsIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.briefcase,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P2,
      );
}

class TasksIcon extends MTIcon {
  const TasksIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.text_badge_checkmark,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P2,
      );
}

class RoubleIcon extends MTIcon {
  const RoubleIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.money_rubl,
        color: (color ?? lightGreyColor).resolve(context),
        size: size ?? P3,
      );
}

class RoubleCircleIcon extends MTIcon {
  const RoubleCircleIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.money_rubl_circle,
        color: (color ?? warningColor).resolve(context),
        size: size ?? P2,
      );
}

class TariffIcon extends MTIcon {
  const TariffIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.creditcard,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P2,
      );
}

class WSIcon extends MTIcon {
  const WSIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.houseUser,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P * 1.45,
      );
}
