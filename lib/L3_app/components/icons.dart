// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_circle.dart';
import 'painters.dart';

abstract class MTIcon extends StatelessWidget {
  const MTIcon({this.color, this.size, this.solid});

  final Color? color;
  final double? size;
  final bool? solid;
}

class BellIcon extends MTIcon {
  const BellIcon({super.color, super.size, this.hasUnread = false});

  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    final _size = size ?? P2;
    final _color = color ?? greyColor;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Icon(
          CupertinoIcons.bell,
          color: _color.resolve(context),
          size: _size,
        ),
        if (hasUnread) MTCircle(size: _size * 0.42, color: _color),
      ],
    );
  }
}

class CalendarIcon extends MTIcon {
  const CalendarIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.calendar,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
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
          painter: TrianglePainter(color: (color ?? greyColor).resolve(context)),
          child: Container(height: size.height, width: size.width),
        ),
      );
}

class ChevronIcon extends MTIcon {
  const ChevronIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.chevronRight,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P * 1.2,
      );
}

class ChevronCircleIcon extends MTIcon {
  const ChevronCircleIcon({super.color, super.size, required this.left});
  final bool left;
  @override
  Widget build(BuildContext context) => Icon(
        left ? CupertinoIcons.chevron_left_circle : CupertinoIcons.chevron_right_circle,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P * 4,
      );
}

class CloseIcon extends MTIcon {
  const CloseIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.clear,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class ConnectingIcon extends MTIcon {
  const ConnectingIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.dot_radiowaves_left_right,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P,
      );
}

class CopyIcon extends MTIcon {
  const CopyIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.doc_on_clipboard,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class DeleteIcon extends MTIcon {
  const DeleteIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.delete,
        color: (color ?? dangerColor).resolve(context),
        size: size ?? P2,
      );
}

class DoneIcon extends MTIcon {
  const DoneIcon(this.done, {super.color, super.size, super.solid});
  final bool done;

  @override
  Widget build(BuildContext context) => Icon(
        done ? (solid == true ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.check_mark_circled) : CupertinoIcons.circle,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class DropdownIcon extends MTIcon {
  const DropdownIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.chevron_up_chevron_down,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class EditIcon extends MTIcon {
  const EditIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        Icons.edit,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class EyeIcon extends MTIcon {
  const EyeIcon({this.open = true, super.color, super.size});
  final bool open;
  @override
  Widget build(BuildContext context) => FaIcon(
        open ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P * 1.7,
      );
}

class ImportIcon extends MTIcon {
  const ImportIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_down_to_line,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P * 1.7,
      );
}

class LinkIcon extends MTIcon {
  const LinkIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.link,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P * 1.4,
      );
}

class LinkOutIcon extends MTIcon {
  const LinkOutIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.arrowUpRightFromSquare,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P,
      );
}

class LogoutIcon extends MTIcon {
  const LogoutIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.arrowRightFromBracket,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P * 1.5,
      );
}

class MenuIcon extends MTIcon {
  const MenuIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.ellipsis_vertical,
        color: (color ?? mainColor).resolve(context),
        size: size,
      );
}

class MailIcon extends MTIcon {
  const MailIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.envelope,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P2,
      );
}

class NetworkErrorIcon extends MTIcon {
  const NetworkErrorIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.wifi_exclamationmark,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P2,
      );
}

class PlusIcon extends MTIcon {
  const PlusIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.plus,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class PrivacyIcon extends MTIcon {
  const PrivacyIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.lock_shield,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P2,
      );
}

class RefreshIcon extends MTIcon {
  const RefreshIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.refresh_thick,
        color: (color ?? mainColor).resolve(context),
        size: size ?? 30,
      );
}

class RulesIcon extends MTIcon {
  const RulesIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.doc_plaintext,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P2,
      );
}

class ServerErrorIcon extends MTIcon {
  const ServerErrorIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.roadBarrier,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P2,
      );
}

class ShareIcon extends MTIcon {
  const ShareIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.square_arrow_up,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class StarIcon extends MTIcon {
  const StarIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.star,
        color: (color ?? warningColor).resolve(context),
        size: size ?? P2,
      );
}

class StartIcon extends MTIcon {
  const StartIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.planeDeparture,
        color: (color ?? borderColor).resolve(context),
        size: size ?? P * 11,
      );
}

class TodayIcon extends MTIcon {
  const TodayIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(CupertinoIcons.placemark, size: size);
}

class UnlinkIcon extends MTIcon {
  const UnlinkIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.linkSlash,
        color: (color ?? warningColor).resolve(context),
        size: size ?? P * 1.4,
      );
}

Widget googleIcon({double? size}) => Image.asset('assets/images/google_icon.png', width: size, height: size);
Widget appIcon({double? size}) => Image.asset('assets/images/app_icon.png', width: size, height: size);
