// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_field_inline.dart';
import '../../../../presenters/task_type.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/title.dart';
import '../toolbars/done_button.dart';

class TaskChecklistItem extends StatefulWidget {
  const TaskChecklistItem(this._tc, {super.key, required this.bottomDivider, this.onSubmit, this.onDelete});
  final TaskController _tc;
  final bool bottomDivider;
  final Function()? onSubmit;
  final Function()? onDelete;

  @override
  State<StatefulWidget> createState() => _TaskChecklistItemState();
}

class _TaskChecklistItemState extends State<TaskChecklistItem> {
  static final _tfIndex = TaskFCode.title.index;

  TaskController get _tc => widget._tc;
  Task get _t => _tc.task;

  bool _fieldHover = false;
  bool _delBtnHover = false;
  bool _deleting = false;
  late final bool _ro;

  FocusNode? fNode;

  void _fNodeListener() => setState(() {});

  @override
  void initState() {
    _ro = !_tc.canEdit;
    if (!_ro) {
      fNode = _tc.focusNode(_tfIndex);
      fNode?.addListener(_fNodeListener);
    }
    super.initState();
  }

  @override
  void dispose() {
    fNode?.removeListener(_fNodeListener);
    super.dispose();
  }

  Future<bool> _delete() async {
    setState(() => _deleting = true);
    if (widget.onDelete != null) await widget.onDelete!();
    return false;
  }

  Widget get _tf => MTTextFieldInline(
        _tc.teController(_tfIndex)!,
        key: widget.key,
        style: BaseText('',
                color: _t.closed
                    ? f3Color
                    : _ro
                        ? f2Color
                        : null)
            .style(context),
        hintText: _t.defaultTitle,
        fNode: fNode,
        autofocus: _t.creating,
        readOnly: _ro,
        textInputAction: TextInputAction.done,
        onTap: () => _tc.setFocus(_tfIndex),
        onChanged: _tc.setTitle,
        onSubmit: widget.onSubmit,
      );

  Widget get _item {
    return Row(
      children: [
        const SizedBox(width: P3),
        if (_t.isCheckItem) ...[
          TaskDoneButton(_tc),
          const SizedBox(width: P2),
        ],

        /// поле ввода
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: P),
            child: _tf,
          ),
        ),
        if (_tc.canDelete)
          if (isWeb)
            Opacity(
              opacity: _fieldHover ? 1 : 0,
              child: MTButton.icon(
                DeleteIcon(color: _delBtnHover ? dangerColor : f2Color, size: P4),
                padding: const EdgeInsets.symmetric(vertical: P, horizontal: P3),
                margin: const EdgeInsets.only(left: P2),
                onHover: (hover) => setState(() => _delBtnHover = hover),
                onTap: _delete,
              ),
            )

          /// это место для захвата свайпа в мобилке
          else
            const SizedBox(width: P6),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final fd = _tc.fData(_tfIndex);
    return MTField(
      fd,
      loading: _deleting,
      value: _ro || isWeb
          ? _item
          : Slidable(
              key: ObjectKey(_tc),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () {},
                  confirmDismiss: _delete,
                ),
                children: [
                  SlidableAction(
                    onPressed: (_) async => await _delete(),
                    backgroundColor: dangerColor.resolve(context),
                    foregroundColor: b3Color.resolve(context),
                    icon: CupertinoIcons.delete,
                    label: loc.action_delete_title,
                  ),
                ],
              ),
              child: _item,
            ),
      padding: EdgeInsets.zero,
      dividerIndent: _t.isCheckItem ? (P5 + DEF_TAPPABLE_ICON_SIZE) : P3,
      dividerEndIndent: P3,
      bottomDivider: widget.bottomDivider,
      onHover: !_ro && isWeb ? (hover) => setState(() => _fieldHover = hover) : null,
      onTap: !_ro ? () => _tc.setFocus(_tfIndex) : null,
    );
  }
}
