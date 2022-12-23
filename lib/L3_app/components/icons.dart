// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'colors.dart';
import 'constants.dart';
import 'painters.dart';

abstract class _MTIcon extends StatelessWidget {
  const _MTIcon({this.color, this.size, this.solid});

  final Color? color;
  final double? size;
  final bool? solid;

  bool get _solid => solid ?? (size == null || size! < 60);
}

class ConnectingIcon extends _MTIcon {
  const ConnectingIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.dot_radiowaves_left_right,
        color: (color ?? darkGreyColor).resolve(context),
        size: size ?? P,
      );
}

class RefreshIcon extends _MTIcon {
  const RefreshIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.refresh_thick,
        color: (color ?? mainColor).resolve(context),
        size: size ?? 30,
      );
}

class ImportIcon extends _MTIcon {
  const ImportIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_down_to_line,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P * 1.7,
      );
}

class WSIcon extends _MTIcon {
  const WSIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.houseUser,
        color: (color ?? darkGreyColor).resolve(context),
        size: size ?? P * 1.45,
      );
}

class PlusIcon extends _MTIcon {
  const PlusIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.plus,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class EditIcon extends _MTIcon {
  const EditIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        Icons.edit,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class DeleteIcon extends _MTIcon {
  const DeleteIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.delete,
        color: (color ?? dangerColor).resolve(context),
        size: size ?? P2,
      );
}

class CalendarIcon extends _MTIcon {
  const CalendarIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.calendar,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class DoneIcon extends _MTIcon {
  const DoneIcon(this.done, {super.color, super.size, super.solid});
  final bool done;

  @override
  Widget build(BuildContext context) => Icon(
        done ? (solid == true ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.check_mark_circled) : CupertinoIcons.circle,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class DropdownIcon extends _MTIcon {
  const DropdownIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.chevron_up_chevron_down,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class ChevronIcon extends _MTIcon {
  const ChevronIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.chevronRight,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P * 1.2,
      );
}

class LinkIcon extends _MTIcon {
  const LinkIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.link,
        color: (color ?? darkGreyColor).resolve(context),
        size: size ?? P * 1.4,
      );
}

class LinkOutIcon extends _MTIcon {
  const LinkOutIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.arrowUpRightFromSquare,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P,
      );
}

class UnlinkIcon extends _MTIcon {
  const UnlinkIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.linkSlash,
        color: (color ?? warningColor).resolve(context),
        size: size ?? P * 1.4,
      );
}

class EyeIcon extends _MTIcon {
  const EyeIcon({this.open = true, super.color, super.size});
  final bool open;
  @override
  Widget build(BuildContext context) => FaIcon(
        open ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
        color: (color ?? darkGreyColor).resolve(context),
        size: size ?? P * 1.7,
      );
}

class CloseIcon extends _MTIcon {
  const CloseIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.clear,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class LogoutIcon extends _MTIcon {
  const LogoutIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.arrowRightFromBracket,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P * 1.5,
      );
}

class MenuIcon extends _MTIcon {
  const MenuIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.ellipsis_vertical,
        color: (color ?? mainColor).resolve(context),
        size: size,
      );
}

class RiskIcon extends _MTIcon {
  const RiskIcon({super.color, super.size, super.solid});

  @override
  Widget build(BuildContext context) => Icon(
        _solid ? CupertinoIcons.tortoise_fill : CupertinoIcons.tortoise,
        color: (color ?? warningColor).resolve(context),
        size: size,
      );
}

class OkIcon extends _MTIcon {
  const OkIcon({super.color, super.size, super.solid});
  @override
  Widget build(BuildContext context) => Icon(
        _solid ? CupertinoIcons.rocket_fill : CupertinoIcons.rocket,
        color: (color ?? greenColor).resolve(context),
        size: size,
      );
}

class NoInfoIcon extends _MTIcon {
  const NoInfoIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.question_circle,
        color: (color ?? lightGreyColor).resolve(context),
        size: size,
      );
}

class PauseIcon extends _MTIcon {
  const PauseIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.pause_circle,
        color: (color ?? lightGreyColor).resolve(context),
        size: size,
      );
}

class PlayIcon extends _MTIcon {
  const PlayIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.play_circle,
        color: (color ?? lightGreyColor).resolve(context),
        size: size,
      );
}

class BacklogIcon extends _MTIcon {
  const BacklogIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.archivebox,
        color: (color ?? lightGreyColor).resolve(context),
        size: size,
      );
}

class CaretIcon extends StatelessWidget {
  const CaretIcon({this.up = false, this.color, required this.size});
  final bool up;
  final Size size;
  final Color? color;

  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: up ? 0 : 2,
        child: CustomPaint(
          painter: TrianglePainter(color: (color ?? darkGreyColor).resolve(context)),
          child: Container(height: size.height, width: size.width),
        ),
      );
}

class TodayIcon extends _MTIcon {
  const TodayIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(CupertinoIcons.placemark, size: size);
}

class MailIcon extends _MTIcon {
  const MailIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.envelope,
        color: (color ?? darkGreyColor).resolve(context),
        size: size ?? P2,
      );
}

class PrivacyIcon extends _MTIcon {
  const PrivacyIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.lock_shield,
        color: (color ?? darkGreyColor).resolve(context),
        size: size ?? P2,
      );
}

class ServerErrorIcon extends _MTIcon {
  const ServerErrorIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.roadBarrier,
        color: (color ?? darkGreyColor).resolve(context),
        size: size ?? P2,
      );
}

class NetworkErrorIcon extends _MTIcon {
  const NetworkErrorIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.wifi_exclamationmark,
        color: (color ?? darkGreyColor).resolve(context),
        size: size ?? P2,
      );
}

class StartIcon extends _MTIcon {
  const StartIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.planeDeparture,
        color: (color ?? borderColor).resolve(context),
        size: size ?? P * 11,
      );
}

double get _sourceIconSize => P2;

Widget redmineIcon() => Image.asset('assets/images/redmine_icon.png', width: _sourceIconSize, height: _sourceIconSize);
Widget gitlabIcon() => Image.asset('assets/images/gitlab_icon.png', width: _sourceIconSize, height: _sourceIconSize);
Widget jiraIcon() => Image.asset('assets/images/jira_icon.png', width: _sourceIconSize, height: _sourceIconSize);
Widget googleIcon({double? size}) => Image.asset('assets/images/google_icon.png', width: size, height: size);
Widget appIcon({double? size}) => Image.asset('assets/images/app_icon.png', width: size, height: size);
