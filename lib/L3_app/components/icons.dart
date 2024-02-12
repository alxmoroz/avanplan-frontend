// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../presenters/mime_type.dart';
import 'circle.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'painters.dart';

class MTIcon extends StatelessWidget {
  const MTIcon(
    this.iconData, {
    super.key,
    this.color = mainColor,
    this.size = P4,
    this.solid = false,
  });

  final IconData? iconData;
  final Color color;
  final double size;
  final bool solid;

  @override
  Widget build(BuildContext context) => Icon(iconData, color: color.resolve(context), size: size);
}

class _Inner extends MTIcon {
  const _Inner(super.iconData, {super.key, super.color, super.size, super.solid, this.circled = false});
  final bool circled;

  @override
  Widget build(BuildContext context) {
    final rColor = color.resolve(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        if (circled == true)
          MTCircle(
            color: solid == true ? rColor.withAlpha(30) : Colors.transparent,
            size: size,
            border: Border.all(color: rColor, width: 2),
          ),
        if (iconData != null)
          MTIcon(
            iconData,
            color: color,
            size: size - (circled == true ? ((size / 3) + 2) : 0),
          ),
      ],
    );
  }
}

class AttachmentIcon extends _Inner {
  const AttachmentIcon({super.key, super.color, super.size = P6, super.circled}) : super(CupertinoIcons.paperclip);
}

class BellIcon extends MTIcon {
  const BellIcon({super.key, super.color, super.size = P6, this.hasUnread = false}) : super(CupertinoIcons.bell);
  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        MTIcon(iconData, color: color, size: size),
        if (hasUnread) MTCircle(size: size * 0.42, color: color),
      ],
    );
  }
}

class BoardIcon extends _Inner {
  const BoardIcon({super.key, super.color, super.size, super.circled}) : super(CupertinoIcons.rectangle_split_3x1);
}

class CalendarIcon extends MTIcon {
  const CalendarIcon({super.key, super.color, super.size = P6, this.startMark = false, this.endMark = false}) : super(CupertinoIcons.calendar);
  final bool startMark;
  final bool endMark;

  @override
  Widget build(BuildContext context) {
    final markSize = size / 2;
    final rColor = color.resolve(context);
    final markColor = rColor.withAlpha(180);
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        MTIcon(iconData, color: rColor, size: size),
        if (startMark)
          Container(
            padding: EdgeInsets.only(top: size / 7, left: size / 8),
            child: Icon(CupertinoIcons.arrowtriangle_right_fill, size: markSize, color: markColor),
          ),
        if (endMark)
          Container(
            padding: EdgeInsets.only(top: size / 7, left: size - markSize - size / 8),
            child: Icon(CupertinoIcons.arrowtriangle_left_fill, size: markSize, color: markColor),
          ),
      ],
    );
  }
}

class CaretIcon extends StatelessWidget {
  const CaretIcon({super.key, this.up = false, this.color, required this.size});
  final bool up;
  final Size size;
  final Color? color;

  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: up ? 0 : 2,
        child: CustomPaint(
          painter: TrianglePainter(color: (color ?? f2Color).resolve(context)),
          child: SizedBox(height: size.height, width: size.width),
        ),
      );
}

class CheckboxIcon extends MTIcon {
  const CheckboxIcon(this.checked, {super.key, super.color, super.size = P6, super.solid})
      : super(checked ? (solid == true ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.checkmark_square) : CupertinoIcons.square);
  final bool checked;
}

class ChevronIcon extends MTIcon {
  const ChevronIcon({super.key, super.color, super.size = P3}) : super(CupertinoIcons.chevron_right);
}

class ChevronCircleIcon extends MTIcon {
  const ChevronCircleIcon({super.key, super.color, super.size = P6, required this.left})
      : super(left ? CupertinoIcons.chevron_left_circle : CupertinoIcons.chevron_right_circle);
  final bool left;
}

class CloseIcon extends MTIcon {
  const CloseIcon({super.key, super.color, super.size = P4}) : super(CupertinoIcons.clear);
}

class CopyIcon extends MTIcon {
  const CopyIcon({super.key, super.color, super.size = P4}) : super(CupertinoIcons.doc_on_clipboard);
}

class DeleteIcon extends _Inner {
  const DeleteIcon({super.key, super.color = dangerColor, super.size = P4, super.circled}) : super(CupertinoIcons.trash);
}

class DescriptionIcon extends MTIcon {
  const DescriptionIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.text_justifyleft);
}

class DocumentIcon extends MTIcon {
  const DocumentIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.doc_plaintext);
}

class DoneIcon extends _Inner {
  const DoneIcon(this.done, {super.key, super.color, super.solid, super.size = P4})
      : super(
          done ? CupertinoIcons.checkmark : null,
          circled: true,
        );
  final bool done;
}

class DownloadIcon extends MTIcon {
  const DownloadIcon({super.key, super.color, super.size}) : super(CupertinoIcons.arrow_down_to_line);
}

class DropdownIcon extends MTIcon {
  const DropdownIcon({super.key, super.color, super.size}) : super(CupertinoIcons.chevron_up_chevron_down);
}

class DuplicateIcon extends _Inner {
  const DuplicateIcon({super.key, super.color = mainColor, super.size, super.circled}) : super(CupertinoIcons.plus_square_on_square);
}

class EditIcon extends MTIcon {
  const EditIcon({super.key, super.color, super.size}) : super(Icons.edit);
}

class ErrorIcon extends MTIcon {
  const ErrorIcon({super.key, super.color = dangerColor, super.size = P3}) : super(CupertinoIcons.exclamationmark_circle);
}

class EstimateIcon extends MTIcon {
  const EstimateIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.rectangle_on_rectangle_angled);
  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: -1,
        child: MTIcon(iconData, color: color, size: size),
      );
}

class EyeIcon extends MTIcon {
  const EyeIcon({super.key, this.open = true, super.color = f2Color, super.size}) : super(open ? CupertinoIcons.eye : CupertinoIcons.eye_slash);
  final bool open;
}

class ExitIcon extends MTIcon {
  const ExitIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.square_arrow_left);
  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: 2,
        child: MTIcon(iconData, color: color, size: size),
      );
}

class FileStorageIcon extends MTIcon {
  const FileStorageIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.cube);
}

class ImportIcon extends MTIcon {
  const ImportIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.cloud_download);
}

class LinkIcon extends MTIcon {
  const LinkIcon({super.key, super.color, super.size = P3}) : super(Icons.link);
}

class LinkBreakIcon extends _Inner {
  const LinkBreakIcon({super.key, super.color = warningColor, super.size, super.circled}) : super(Icons.link_off);
}

class LinkOutIcon extends MTIcon {
  const LinkOutIcon({super.key, super.color, super.size = P3}) : super(CupertinoIcons.arrow_up_right);
}

class ListIcon extends _Inner {
  const ListIcon({super.key, super.color = mainColor, super.size, super.circled}) : super(CupertinoIcons.list_dash);
}

class LocalExportIcon extends _Inner {
  const LocalExportIcon({super.key, super.color = mainColor, super.size, super.circled}) : super(CupertinoIcons.arrow_up);
}

class LocalImportIcon extends _Inner {
  const LocalImportIcon({super.key, super.color = mainColor, super.size, super.circled}) : super(CupertinoIcons.arrow_down);
}

class MailIcon extends MTIcon {
  const MailIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.envelope);
}

class MemberAddIcon extends MTIcon {
  const MemberAddIcon({super.key, super.color, super.size}) : super(CupertinoIcons.person_crop_circle_badge_plus);
}

class MenuIcon extends _Inner {
  const MenuIcon({super.key, super.color = mainColor, super.size, super.circled}) : super(CupertinoIcons.ellipsis_vertical);
}

class MimeTypeIcon extends MTIcon {
  MimeTypeIcon(this.mimeType, {super.key, super.color, super.size = P6}) : super(mimeType.iconData);
  final String mimeType;
}

class NoteAddIcon extends _Inner {
  const NoteAddIcon({super.key, super.color = mainColor, super.size = P4, super.circled}) : super(CupertinoIcons.bubble_right);
}

class NoteMarkIcon extends MTIcon {
  const NoteMarkIcon({super.key, this.mine = true, this.theirs = true, super.color = f2Color, super.size = P3})
      : super(mine && theirs
            ? CupertinoIcons.bubble_left_bubble_right
            : mine
                ? CupertinoIcons.bubble_right
                : CupertinoIcons.bubble_left);
  final bool mine;
  final bool theirs;
}

class PersonIcon extends MTIcon {
  const PersonIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.person_circle);
}

class PlusIcon extends _Inner {
  const PlusIcon({super.key, super.color = mainColor, super.size = P4, super.circled}) : super(CupertinoIcons.plus);
}

class PrivacyIcon extends MTIcon {
  const PrivacyIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.lock_shield);
}

class RefreshIcon extends MTIcon {
  const RefreshIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.refresh);
}

class SettingsIcon extends MTIcon {
  const SettingsIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.slider_horizontal_3);
}

class ShareIcon extends MTIcon {
  const ShareIcon({super.key, super.color, super.size}) : super(CupertinoIcons.square_arrow_up);
}

class StarIcon extends MTIcon {
  const StarIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.star);
}

class StatusIcon extends MTIcon {
  const StatusIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.rectangle_split_3x1);
}

class SubmitIcon extends MTIcon {
  const SubmitIcon({super.key, super.color, super.size}) : super(CupertinoIcons.arrow_up);
}

class TasksIcon extends _Inner {
  const TasksIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.checkmark, solid: false, circled: true);
}

class TemplateIcon extends MTIcon {
  const TemplateIcon({super.key, super.color, super.size = P6}) : super(CupertinoIcons.collections);
}

Widget get appleIcon => Image.asset('assets/icons/apple_icon.png', width: MIN_BTN_HEIGHT - 2, height: MIN_BTN_HEIGHT - 2);
Widget get googleIcon => Image.asset('assets/icons/google_icon.png', width: MIN_BTN_HEIGHT - 2, height: MIN_BTN_HEIGHT - 2);
