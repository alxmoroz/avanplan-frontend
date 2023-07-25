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
    final _color = color ?? greyTextColor;
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

class BoardIcon extends MTIcon {
  const BoardIcon({super.color, super.size, this.active = false});
  final bool active;
  @override
  Widget build(BuildContext context) => Icon(
        active ? CupertinoIcons.rectangle_split_3x1_fill : CupertinoIcons.rectangle_split_3x1,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2 * (active ? 0.8 : 1),
      );
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
          painter: TrianglePainter(color: (color ?? greyTextColor).resolve(context)),
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
        size: size ?? P,
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

class DescriptionIcon extends MTIcon {
  const DescriptionIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.text_justifyleft,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P3,
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

class EstimateIcon extends MTIcon {
  const EstimateIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: -1,
        child: Icon(
          CupertinoIcons.rectangle_on_rectangle_angled,
          color: (color ?? mainColor).resolve(context),
          size: size ?? P3,
        ),
      );
}

class EyeIcon extends MTIcon {
  const EyeIcon({this.open = true, super.color, super.size});
  final bool open;
  @override
  Widget build(BuildContext context) => FaIcon(
        open ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
        color: (color ?? greyTextColor).resolve(context),
        size: size ?? P * 1.8,
      );
}

class ImportIcon extends MTIcon {
  const ImportIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_down_to_line,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class LinkIcon extends MTIcon {
  const LinkIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.link,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P * 1.4,
      );
}

class LinkBreakIcon extends MTIcon {
  const LinkBreakIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => FaIcon(
        FontAwesomeIcons.linkSlash,
        color: (color ?? warningColor).resolve(context),
        size: size ?? P * 1.4,
      );
}

class LinkOutIcon extends MTIcon {
  const LinkOutIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_up_right,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class ListIcon extends MTIcon {
  const ListIcon({super.color, super.size, this.active = false});
  final bool active;
  @override
  Widget build(BuildContext context) => RotatedBox(
      quarterTurns: 1,
      child: Icon(
        active ? CupertinoIcons.rectangle_split_3x1_fill : CupertinoIcons.rectangle_split_3x1,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2 * (active ? 0.8 : 1),
      ));
}

class LocalExportIcon extends MTIcon {
  const LocalExportIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_up,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class LocalImportIcon extends MTIcon {
  const LocalImportIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_down,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
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
        color: (color ?? greyTextColor).resolve(context),
        size: size ?? P2,
      );
}

class NoteAddIcon extends MTIcon {
  const NoteAddIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.plus_bubble,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P3,
      );
}

class NoteMarkIcon extends MTIcon {
  const NoteMarkIcon({this.mine = true, this.theirs = true, super.color, super.size});
  final bool mine;
  final bool theirs;
  @override
  Widget build(BuildContext context) => Icon(
        mine && theirs
            ? CupertinoIcons.bubble_left_bubble_right
            : mine
                ? CupertinoIcons.bubble_right
                : CupertinoIcons.bubble_left,
        color: (color ?? greyColor).resolve(context),
        size: size ?? P * 1.5,
      );
}

class PersonIcon extends MTIcon {
  const PersonIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.person,
        color: (color ?? greyTextColor).resolve(context),
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
        color: (color ?? greyTextColor).resolve(context),
        size: size ?? P2,
      );
}

class RefreshIcon extends MTIcon {
  const RefreshIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.refresh_thick,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P2,
      );
}

class RulesIcon extends MTIcon {
  const RulesIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.doc_plaintext,
        color: (color ?? greyTextColor).resolve(context),
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
        CupertinoIcons.star_fill,
        color: (color ?? goldColor).resolve(context),
        size: size ?? P2,
      );
}

Widget get appleIcon => Image.asset('assets/icons/apple_icon.png', width: MIN_BTN_HEIGHT, height: MIN_BTN_HEIGHT);
Widget get googleIcon => Image.asset('assets/icons/google_icon.png', width: MIN_BTN_HEIGHT, height: MIN_BTN_HEIGHT);
Widget appIcon({double? size}) => Image.asset('assets/icons/app_icon.png', width: size, height: size);
