// Copyright (c) 2024. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../presenters/mime_type.dart';
import 'circle.dart';
import 'colors.dart';
import 'constants.dart';
import 'painters.dart';

const DEF_TAPPABLE_ICON_SIZE = kIsWeb ? P5 : P6;

class MTIcon extends StatelessWidget {
  const MTIcon(
    this.iconData, {
    super.key,
    this.color = mainColor,
    this.size = P4,
    this.solid = false,
    this.circled = false,
  });

  final IconData? iconData;
  final Color color;
  final double size;
  final bool solid;
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
            // от 1 до 3 пикселей ширина обводки, в зависимости от размера иконки
            border: Border.all(color: rColor, width: min(3, max(1, size / 18))),
          ),
        if (iconData != null)
          Icon(
            iconData,
            color: rColor,
            size: size - (circled == true ? (sqrt(size * size / 8)) : 0),
          ),
      ],
    );
  }
}

class AnalyticsIcon extends MTIcon {
  const AnalyticsIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE, super.circled}) : super(CupertinoIcons.chart_bar);
}

class ArrowDownIcon extends MTIcon {
  const ArrowDownIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE, super.circled}) : super(CupertinoIcons.arrow_down);
}

class AttachmentIcon extends MTIcon {
  const AttachmentIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE, super.circled}) : super(CupertinoIcons.paperclip);
}

class BankCardIcon extends MTIcon {
  const BankCardIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.creditcard);
}

class BellIcon extends MTIcon {
  const BellIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE, this.hasUnread = false}) : super(CupertinoIcons.bell);
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

class BoardIcon extends MTIcon {
  const BoardIcon({super.key, super.color, super.size, super.circled}) : super(CupertinoIcons.rectangle_split_3x1);
}

class CalendarIcon extends MTIcon {
  const CalendarIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.calendar);
}

class CameraIcon extends MTIcon {
  const CameraIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.camera);
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
  const CheckboxIcon(this.checked, {super.key, super.color, super.size = P4, super.solid})
      : super(
          checked ? (solid == true ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.checkmark_square) : CupertinoIcons.square,
        );
  final bool checked;
}

class ChevronIcon extends MTIcon {
  const ChevronIcon({super.key, super.color, super.size = P3, this.left = false})
      : super(left ? CupertinoIcons.chevron_left : CupertinoIcons.chevron_right);
  final bool left;
}

class ChevronCircleIcon extends MTIcon {
  const ChevronCircleIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE, required this.left})
      : super(
          left ? CupertinoIcons.chevron_left_circle : CupertinoIcons.chevron_right_circle,
        );
  final bool left;
}

class ChevronCaretIcon extends StatelessWidget {
  const ChevronCaretIcon({super.key, this.left = false, this.color = mainColor, required this.size});
  final bool left;
  final Size size;
  final Color? color;

  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: left ? 3 : 1,
        child: CustomPaint(
          painter: TrianglePainter(color: (color ?? f2Color).resolve(context)),
          child: SizedBox(height: size.height, width: size.width),
        ),
      );
}

class CloseIcon extends MTIcon {
  const CloseIcon({super.key, super.color, super.size = P4}) : super(CupertinoIcons.clear);
}

class CopyIcon extends MTIcon {
  const CopyIcon({super.key, super.color, super.size = P4}) : super(CupertinoIcons.doc_on_clipboard);
}

class DeleteIcon extends MTIcon {
  const DeleteIcon({super.key, super.color = dangerColor, super.size = P4, super.circled}) : super(CupertinoIcons.trash);
}

class DescriptionIcon extends MTIcon {
  const DescriptionIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.text_justifyleft);
}

class DocumentIcon extends MTIcon {
  const DocumentIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.doc_plaintext);
}

class DoneIcon extends MTIcon {
  const DoneIcon(this.done, {super.key, super.color, super.solid, super.size = P4, super.circled = true})
      : super(
          done ? CupertinoIcons.checkmark : null,
        );
  final bool done;
}

class DropdownIcon extends MTIcon {
  const DropdownIcon({super.key, super.color, super.size}) : super(CupertinoIcons.chevron_up_chevron_down);
}

class DuplicateIcon extends MTIcon {
  const DuplicateIcon({super.key, super.color, super.size, super.circled}) : super(CupertinoIcons.plus_square_on_square);
}

class EditIcon extends MTIcon {
  const EditIcon({super.key, super.color, super.size}) : super(Icons.edit);
}

class ErrorIcon extends MTIcon {
  const ErrorIcon({super.key, super.color = dangerColor, super.size = P3}) : super(CupertinoIcons.exclamationmark_circle);
}

class EstimateIcon extends MTIcon {
  const EstimateIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.rectangle_on_rectangle_angled);
  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: -1,
        child: MTIcon(iconData, color: color, size: size),
      );
}

class EyeIcon extends MTIcon {
  const EyeIcon({super.key, this.open = true, super.color = f2Color, super.size})
      : super(
          open ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
        );
  final bool open;
}

class FeaturesIcon extends MTIcon {
  const FeaturesIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.square_grid_2x2);
}

class FeedbackIcon extends MTIcon {
  const FeedbackIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.hand_thumbsup);
}

class FileStorageIcon extends MTIcon {
  const FileStorageIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.cube);
}

class FilterIcon extends MTIcon {
  const FilterIcon({super.key, super.color, super.size = P3}) : super(CupertinoIcons.line_horizontal_3_decrease);
}

class FinanceIcon extends MTIcon {
  const FinanceIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.money_rubl, circled: true);
}

class FinanceExpensesIcon extends MTIcon {
  const FinanceExpensesIcon({super.key, super.color, super.size = P4}) : super(CupertinoIcons.arrow_down_right);
}

class FinanceIncomeIcon extends MTIcon {
  const FinanceIncomeIcon({super.key, super.color, super.size = P4}) : super(CupertinoIcons.arrow_up_right);
}

class HomeIcon extends MTIcon {
  const HomeIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.house_alt);
}

class ImportIcon extends MTIcon {
  const ImportIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.cloud_download);
}

class InboxAddIcon extends MTIcon {
  const InboxAddIcon({super.key, super.color, super.size = P4, super.circled, super.solid}) : super(CupertinoIcons.plus);
}

class InboxIcon extends MTIcon {
  const InboxIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.tray);
}

class InfoIcon extends MTIcon {
  const InfoIcon({super.key, super.color = mainColor, super.size = P5}) : super(CupertinoIcons.info);
}

class LinkIcon extends MTIcon {
  const LinkIcon({super.key, super.color, super.size = P3}) : super(Icons.link);
}

class LinkOffIcon extends MTIcon {
  const LinkOffIcon({super.key, super.color = dangerColor, super.size, super.circled}) : super(Icons.link_off);
}

class LinkOutIcon extends MTIcon {
  const LinkOutIcon({super.key, super.color, super.size = P3}) : super(CupertinoIcons.arrow_up_right);
}

class ListIcon extends MTIcon {
  const ListIcon({super.key, super.color, super.size, super.circled}) : super(CupertinoIcons.list_dash);
}

class LocalExportIcon extends MTIcon {
  const LocalExportIcon({super.key, super.color, super.size, super.circled}) : super(CupertinoIcons.shift);
}

class LocalImportIcon extends MTIcon {
  const LocalImportIcon({super.key, super.color, super.size, super.circled}) : super(CupertinoIcons.arrow_down_right_square);
}

class LocationIcon extends MTIcon {
  const LocationIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE, super.circled}) : super(CupertinoIcons.location_solid);
}

class MailIcon extends MTIcon {
  const MailIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE, super.circled}) : super(CupertinoIcons.envelope);
}

class MemberAddIcon extends MTIcon {
  const MemberAddIcon({super.key, super.color, super.size}) : super(CupertinoIcons.person_crop_circle_badge_plus);
}

class MenuIcon extends MTIcon {
  const MenuIcon({super.key, super.color, super.size, super.circled}) : super(CupertinoIcons.ellipsis_vertical);
}

class MenuHorizontalIcon extends MTIcon {
  const MenuHorizontalIcon({super.key, super.color, super.size, super.circled}) : super(CupertinoIcons.ellipsis);
}

class MimeTypeIcon extends MTIcon {
  MimeTypeIcon(this.mimeType, {super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(mimeType.iconData);
  final String mimeType;
}

class MoveLeftIcon extends MTIcon {
  const MoveLeftIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.arrow_left);
}

class MoveRightIcon extends MTIcon {
  const MoveRightIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.arrow_right);
}

class NoteAddIcon extends MTIcon {
  const NoteAddIcon({super.key, super.color, super.size = P4, super.circled}) : super(CupertinoIcons.bubble_right);
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
  const PersonIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.person_fill, circled: true);
}

class PersonNoAvatarIcon extends MTIcon {
  const PersonNoAvatarIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE, super.circled}) : super(CupertinoIcons.person);
}

class PhoneIcon extends MTIcon {
  const PhoneIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.phone);
}

class PlusIcon extends MTIcon {
  const PlusIcon({super.key, super.color, super.size = P4, super.circled}) : super(CupertinoIcons.plus);
}

class PeopleIcon extends MTIcon {
  const PeopleIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.person_2);
}

class PrivacyIcon extends MTIcon {
  const PrivacyIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.lock_shield);
}

class ProjectsIcon extends MTIcon {
  const ProjectsIcon({super.key, super.color = f2Color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.folder);
}

class RepeatIcon extends MTIcon {
  const RepeatIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.repeat);
}

class QuestionIcon extends MTIcon {
  const QuestionIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.question_circle);
}

class ReleaseNotesIcon extends MTIcon {
  const ReleaseNotesIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.time);
}

class SettingsIcon extends MTIcon {
  const SettingsIcon({super.key, super.color, super.circled, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.slider_horizontal_3);
}

class ShareIcon extends MTIcon {
  const ShareIcon({super.key, super.color, super.size}) : super(CupertinoIcons.square_arrow_up);
}

class StarIcon extends MTIcon {
  const StarIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.star);
}

class SubmitIcon extends MTIcon {
  const SubmitIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.arrow_up);
  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          MTCircle(color: color, size: size),
          MTIcon(iconData, color: mainBtnTitleColor, size: size * 0.7),
        ],
      );
}

class TasksIcon extends MTIcon {
  const TasksIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.checkmark, solid: false, circled: true);
}

class TemplateIcon extends MTIcon {
  const TemplateIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.collections);
}

class WebIcon extends MTIcon {
  const WebIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.globe);
}

class WSPublicIcon extends MTIcon {
  const WSPublicIcon({super.key, super.color, super.size = DEF_TAPPABLE_ICON_SIZE}) : super(CupertinoIcons.building_2_fill);
}

Widget get googleIcon => Image.asset('assets/icons/google_icon.png', width: P6, height: P6);
Widget get yandexIcon => Image.asset('assets/icons/yandex_icon.png', width: P6, height: P6);
