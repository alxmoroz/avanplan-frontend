// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../presenters/mime_type.dart';
import 'circle.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'painters.dart';

abstract class MTIcon extends StatelessWidget {
  const MTIcon({super.key, this.color, this.size, this.solid, this.circled});

  final Color? color;
  final double? size;
  final bool? solid;
  final bool? circled;
}

class _Inner extends MTIcon {
  const _Inner(this.iconData, {required super.color, required super.size, super.solid, super.circled});
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    final rColor = color!.resolve(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        if (circled == true)
          MTCircle(
            color: solid == true ? rColor : Colors.transparent,
            size: size,
            border: Border.all(color: rColor, width: 2),
          ),
        if (iconData != null)
          Icon(
            iconData,
            color: rColor,
            size: size! - (circled == true ? ((size! / 3) + 2) : 0),
          ),
      ],
    );
  }
}

class AttachmentIcon extends MTIcon {
  const AttachmentIcon({super.key, super.color, super.size = P6});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.paperclip,
        color: (color ?? mainColor).resolve(context),
        size: size,
      );
}

class BellIcon extends MTIcon {
  const BellIcon({super.key, super.color = mainColor, super.size = P6, this.hasUnread = false});

  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Icon(
          CupertinoIcons.bell,
          color: color!.resolve(context),
          size: size,
        ),
        if (hasUnread) MTCircle(size: size! * 0.42, color: color),
      ],
    );
  }
}

class BoardIcon extends MTIcon {
  const BoardIcon({super.key, super.color, super.size, super.circled});
  @override
  Widget build(BuildContext context) => _Inner(
        CupertinoIcons.rectangle_split_3x1,
        color: color ?? mainColor,
        size: size ?? P4,
        circled: circled,
      );
}

class CalendarIcon extends MTIcon {
  const CalendarIcon({super.key, super.color, super.size = P6, this.startMark = false, this.endMark = false});
  final bool startMark;
  final bool endMark;

  @override
  Widget build(BuildContext context) {
    final markSize = size! / 2;
    final rColor = (color ?? mainColor).resolve(context);
    final markColor = rColor.withAlpha(180);
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Icon(CupertinoIcons.calendar, color: rColor, size: size),
        if (startMark)
          Container(
            padding: EdgeInsets.only(top: size! / 7, left: size! / 8),
            child: Icon(CupertinoIcons.arrowtriangle_right_fill, size: markSize, color: markColor),
          ),
        if (endMark)
          Container(
            padding: EdgeInsets.only(top: size! / 7, left: size! - markSize - size! / 8),
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
  const CheckboxIcon(this.checked, {super.key, super.color, super.size, super.solid});
  final bool checked;

  @override
  Widget build(BuildContext context) => Icon(
        checked ? (solid == true ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.checkmark_square) : CupertinoIcons.square,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class ChevronIcon extends MTIcon {
  const ChevronIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.chevron_right,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P3,
      );
}

class ChevronCircleIcon extends MTIcon {
  const ChevronCircleIcon({super.key, super.color, super.size, required this.left});
  final bool left;
  @override
  Widget build(BuildContext context) => Icon(
        left ? CupertinoIcons.chevron_left_circle : CupertinoIcons.chevron_right_circle,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class CloseIcon extends MTIcon {
  const CloseIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.clear,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class CopyIcon extends MTIcon {
  const CopyIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.doc_on_clipboard,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class DeleteIcon extends MTIcon {
  const DeleteIcon({super.key, super.color, super.size, super.circled});
  @override
  Widget build(BuildContext context) {
    return _Inner(
      CupertinoIcons.trash,
      color: color ?? dangerColor,
      size: size ?? P4,
      circled: circled,
    );
  }
}

class DescriptionIcon extends MTIcon {
  const DescriptionIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.text_justifyleft,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class DocumentIcon extends MTIcon {
  const DocumentIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.doc_plaintext,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class DoneIcon extends MTIcon {
  const DoneIcon(this.done, {super.key, super.color, super.size, super.solid});
  final bool done;

  @override
  Widget build(BuildContext context) {
    return _Inner(
      done ? CupertinoIcons.checkmark : null,
      color: color ?? mainColor,
      size: size ?? P4,
      solid: solid,
      circled: true,
    );
  }
}

class DownloadIcon extends MTIcon {
  const DownloadIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_down_to_line,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class DropdownIcon extends MTIcon {
  const DropdownIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.chevron_up_chevron_down,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class DuplicateIcon extends MTIcon {
  const DuplicateIcon({super.key, super.color, super.size, super.circled});
  @override
  Widget build(BuildContext context) {
    return _Inner(
      CupertinoIcons.plus_square_on_square,
      color: color ?? mainColor,
      size: size ?? P4,
      circled: circled,
    );
  }
}

class EditIcon extends MTIcon {
  const EditIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        Icons.edit,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class ErrorIcon extends MTIcon {
  const ErrorIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.exclamationmark_circle,
        color: (color ?? dangerColor).resolve(context),
        size: size ?? P3,
      );
}

class EstimateIcon extends MTIcon {
  const EstimateIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: -1,
        child: Icon(
          CupertinoIcons.rectangle_on_rectangle_angled,
          color: (color ?? mainColor).resolve(context),
          size: size ?? P6,
        ),
      );
}

class EyeIcon extends MTIcon {
  const EyeIcon({super.key, this.open = true, super.color, super.size});
  final bool open;
  @override
  Widget build(BuildContext context) => Icon(
        open ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
        color: (color ?? f2Color).resolve(context),
        size: size ?? P4,
      );
}

class ExitIcon extends MTIcon {
  const ExitIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: 2,
        child: Icon(
          CupertinoIcons.square_arrow_left,
          color: (color ?? mainColor).resolve(context),
          size: size ?? P6,
        ),
      );
}

class FileStorageIcon extends MTIcon {
  const FileStorageIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.cube,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class ImportIcon extends MTIcon {
  const ImportIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.cloud_download,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class LinkIcon extends MTIcon {
  const LinkIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        Icons.link,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P3,
      );
}

class LinkBreakIcon extends MTIcon {
  const LinkBreakIcon({super.key, super.color, super.size, super.circled});
  @override
  Widget build(BuildContext context) => _Inner(
        Icons.link_off,
        color: color ?? warningColor,
        size: size ?? P4,
        circled: circled,
      );
}

class LinkOutIcon extends MTIcon {
  const LinkOutIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_up_right,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P3,
      );
}

class ListIcon extends MTIcon {
  const ListIcon({super.key, super.color, super.size, super.circled});
  @override
  Widget build(BuildContext context) => _Inner(
        CupertinoIcons.list_dash,
        color: color ?? mainColor,
        size: size ?? P4,
        circled: circled,
      );
}

class LocalExportIcon extends MTIcon {
  const LocalExportIcon({super.key, super.color, super.size, super.circled});
  @override
  Widget build(BuildContext context) {
    return _Inner(
      CupertinoIcons.arrow_up,
      color: color ?? mainColor,
      size: size ?? P4,
      circled: circled,
    );
  }
}

class LocalImportIcon extends MTIcon {
  const LocalImportIcon({super.key, super.color, super.size, super.circled});
  @override
  Widget build(BuildContext context) {
    return _Inner(
      CupertinoIcons.arrow_down,
      color: color ?? mainColor,
      size: size ?? P4,
      circled: circled,
    );
  }
}

class MailIcon extends MTIcon {
  const MailIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.envelope,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class MemberAddIcon extends MTIcon {
  const MemberAddIcon({super.key, super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.person_crop_circle_badge_plus,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class MenuIcon extends MTIcon {
  const MenuIcon({super.key, super.color, super.size, super.circled});
  @override
  Widget build(BuildContext context) => _Inner(
        CupertinoIcons.ellipsis_vertical,
        color: color ?? mainColor,
        size: size ?? P4,
        circled: circled,
      );
}

class MimeTypeIcon extends MTIcon {
  const MimeTypeIcon({super.key, super.color, super.size, this.mimeType = ''});
  final String mimeType;

  @override
  Widget build(BuildContext context) => Icon(
        mimeType.iconData,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class NoteAddIcon extends MTIcon {
  const NoteAddIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.plus_bubble,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class NoteMarkIcon extends MTIcon {
  const NoteMarkIcon({super.key, this.mine = true, this.theirs = true, super.color, super.size});
  final bool mine;
  final bool theirs;
  @override
  Widget build(BuildContext context) => Icon(
        mine && theirs
            ? CupertinoIcons.bubble_left_bubble_right
            : mine
                ? CupertinoIcons.bubble_right
                : CupertinoIcons.bubble_left,
        color: (color ?? f2Color).resolve(context),
        size: size ?? P3,
      );
}

class PersonIcon extends MTIcon {
  const PersonIcon({super.key, super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.person_circle,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class PlusIcon extends MTIcon {
  const PlusIcon({super.key, super.color, super.size, super.circled});
  @override
  Widget build(BuildContext context) => _Inner(
        CupertinoIcons.plus,
        color: color ?? mainColor,
        size: size ?? P4,
        circled: circled,
      );
}

class PrivacyIcon extends MTIcon {
  const PrivacyIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.lock_shield,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class RefreshIcon extends MTIcon {
  const RefreshIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.refresh,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class SettingsIcon extends MTIcon {
  const SettingsIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.slider_horizontal_3,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class ShareIcon extends MTIcon {
  const ShareIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.square_arrow_up,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class StarIcon extends MTIcon {
  const StarIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.star,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class StatusIcon extends MTIcon {
  const StatusIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.rectangle_split_3x1,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class SubmitIcon extends MTIcon {
  const SubmitIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_up,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class TasksIcon extends MTIcon {
  const TasksIcon({super.key, super.color, super.size});

  @override
  Widget build(BuildContext context) => DoneIcon(true, color: color, size: size ?? P6);
}

class TemplateIcon extends MTIcon {
  const TemplateIcon({super.key, super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.collections,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

Widget get appleIcon => Image.asset('assets/icons/apple_icon.png', width: MIN_BTN_HEIGHT - 2, height: MIN_BTN_HEIGHT - 2);
Widget get googleIcon => Image.asset('assets/icons/google_icon.png', width: MIN_BTN_HEIGHT - 2, height: MIN_BTN_HEIGHT - 2);
