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
  const MTIcon({this.color, this.size, this.solid});

  final Color? color;
  final double? size;
  final bool? solid;
}

class _Circled extends MTIcon {
  const _Circled(this.child, {required super.color, required super.size, super.solid});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MTCircle(
          color: solid == true ? color!.resolve(context) : Colors.transparent,
          size: size,
          border: Border.all(color: color!.resolve(context), width: 2),
        ),
        child,
      ],
    );
  }
}

class AttachmentIcon extends MTIcon {
  const AttachmentIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.paperclip,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class BellIcon extends MTIcon {
  const BellIcon({super.color, super.size, this.hasUnread = false});

  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    final _size = size ?? P6;
    final _color = color ?? mainColor;
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
        size: size ?? P4 * (active ? 0.8 : 1),
      );
}

class CalendarIcon extends MTIcon {
  const CalendarIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.calendar,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
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
          painter: TrianglePainter(color: (color ?? f2Color).resolve(context)),
          child: Container(height: size.height, width: size.width),
        ),
      );
}

class CheckboxIcon extends MTIcon {
  const CheckboxIcon(this.checked, {super.color, super.size, super.solid});
  final bool checked;

  @override
  Widget build(BuildContext context) => Icon(
        checked ? (solid == true ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.checkmark_square) : CupertinoIcons.square,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P5,
      );
}

class ChevronIcon extends MTIcon {
  const ChevronIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.chevron_right,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P3,
      );
}

class ChevronCircleIcon extends MTIcon {
  const ChevronCircleIcon({super.color, super.size, required this.left});
  final bool left;
  @override
  Widget build(BuildContext context) => Icon(
        left ? CupertinoIcons.chevron_left_circle : CupertinoIcons.chevron_right_circle,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class CloseIcon extends MTIcon {
  const CloseIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.clear,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class CopyIcon extends MTIcon {
  const CopyIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.doc_on_clipboard,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class DeleteIcon extends MTIcon {
  const DeleteIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) {
    final _color = (color ?? dangerColor).resolve(context);
    final _size = size ?? P4;
    return _Circled(
      Icon(
        CupertinoIcons.trash,
        color: _color,
        size: _size - _size / 3 - 3,
      ),
      color: _color,
      size: _size,
    );
  }
}

class DescriptionIcon extends MTIcon {
  const DescriptionIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.text_justifyleft,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class DocumentIcon extends MTIcon {
  const DocumentIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.doc_plaintext,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class DoneIcon extends MTIcon {
  const DoneIcon(this.done, {super.color, super.size, super.solid});
  final bool done;

  @override
  Widget build(BuildContext context) {
    final _color = (color ?? mainColor).resolve(context);
    final _size = size ?? P4;
    return _Circled(
      done
          ? Icon(
              CupertinoIcons.checkmark,
              color: _color,
              size: _size - _size / 3 - 3,
            )
          : Container(),
      color: _color,
      size: _size,
      solid: solid,
    );
  }
}

class DownloadIcon extends MTIcon {
  const DownloadIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_down_to_line,
        // CupertinoIcons.arrow_down_circle,
        // Icons.file_download,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P5,
      );
}

class DropdownIcon extends MTIcon {
  const DropdownIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.chevron_up_chevron_down,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class DuplicateIcon extends MTIcon {
  const DuplicateIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) {
    final _color = (color ?? mainColor).resolve(context);
    final _size = size ?? P4;
    return _Circled(
      Icon(
        CupertinoIcons.plus_square_on_square,
        color: _color,
        size: _size - _size / 3 - 3,
      ),
      color: _color,
      size: _size,
    );
  }
}

class EditIcon extends MTIcon {
  const EditIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        Icons.edit,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class ErrorIcon extends MTIcon {
  const ErrorIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.exclamationmark_circle,
        color: (color ?? dangerColor).resolve(context),
        size: size ?? P3,
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
          size: size ?? P6,
        ),
      );
}

class EyeIcon extends MTIcon {
  const EyeIcon({this.open = true, super.color, super.size});
  final bool open;
  @override
  Widget build(BuildContext context) => Icon(
        open ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
        color: (color ?? f2Color).resolve(context),
        size: size ?? P4,
      );
}

class ExitIcon extends MTIcon {
  const ExitIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: 2,
        child: Icon(
          CupertinoIcons.square_arrow_left,
          color: (color ?? mainColor).resolve(context),
          size: size ?? P5,
        ),
      );
}

class ImportIcon extends MTIcon {
  const ImportIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.cloud_download,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P5,
      );
}

class LinkIcon extends MTIcon {
  const LinkIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        Icons.link,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P3,
      );
}

class LinkBreakIcon extends MTIcon {
  const LinkBreakIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        Icons.link_off,
        color: (color ?? warningColor).resolve(context),
        size: size ?? P4,
      );
}

class LinkOutIcon extends MTIcon {
  const LinkOutIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_up_right,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P3,
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
        size: size ?? P4 * (active ? 0.8 : 1),
      ));
}

class LocalExportIcon extends MTIcon {
  const LocalExportIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) {
    final _color = (color ?? mainColor).resolve(context);
    final _size = size ?? P4;
    return _Circled(
      Icon(
        CupertinoIcons.arrow_up,
        color: _color,
        size: _size - _size / 3 - 3,
      ),
      color: _color,
      size: _size,
    );
  }
}

class LocalImportIcon extends MTIcon {
  const LocalImportIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) {
    final _color = (color ?? mainColor).resolve(context);
    final _size = size ?? P4;
    return _Circled(
      Icon(
        CupertinoIcons.arrow_down,
        color: _color,
        size: _size - _size / 3 - 3,
      ),
      color: _color,
      size: _size,
    );
  }
}

class MailIcon extends MTIcon {
  const MailIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.envelope,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class MemberAddIcon extends MTIcon {
  const MemberAddIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.person_crop_circle_badge_plus,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
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

class MimeTypeIcon extends MTIcon {
  const MimeTypeIcon({super.color, super.size, this.mimeType = ''});
  final String mimeType;

  @override
  Widget build(BuildContext context) => Icon(
        mimeType.iconData,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P5,
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
        color: (color ?? f2Color).resolve(context),
        size: size ?? P3,
      );
}

class PersonIcon extends MTIcon {
  const PersonIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.person_circle,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class PlusIcon extends MTIcon {
  const PlusIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.plus,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class PlusCircleIcon extends MTIcon {
  const PlusCircleIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.plus_circle,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class PrivacyIcon extends MTIcon {
  const PrivacyIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.lock_shield,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class RefreshIcon extends MTIcon {
  const RefreshIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.refresh_thick,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class SettingsIcon extends MTIcon {
  const SettingsIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.slider_horizontal_3,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

class ShareIcon extends MTIcon {
  const ShareIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.square_arrow_up,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class StarIcon extends MTIcon {
  const StarIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.star,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P5,
      );
}

class StatusIcon extends MTIcon {
  const StatusIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.rectangle_split_3x1,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P5,
      );
}

class SubmitIcon extends MTIcon {
  const SubmitIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.arrow_up,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P4,
      );
}

class TasksIcon extends MTIcon {
  const TasksIcon({super.color, super.size});

  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.checkmark_circle,
        color: (color ?? f2Color).resolve(context),
        size: size ?? P4,
      );
}

class TemplateIcon extends MTIcon {
  const TemplateIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        // CupertinoIcons.lightbulb,
        CupertinoIcons.collections,
        color: (color ?? mainColor).resolve(context),
        size: size ?? P6,
      );
}

Widget get appleIcon => Image.asset('assets/icons/apple_icon.png', width: MIN_BTN_HEIGHT - 2, height: MIN_BTN_HEIGHT - 2);
Widget get googleIcon => Image.asset('assets/icons/google_icon.png', width: MIN_BTN_HEIGHT - 2, height: MIN_BTN_HEIGHT - 2);
