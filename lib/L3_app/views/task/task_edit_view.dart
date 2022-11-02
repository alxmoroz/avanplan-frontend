// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/usecases/task_ext_level.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import 'task_edit_controller.dart';

//TODO: подумать над унификацией полей. Возможно, получится избавиться от дуэта MTField и TFAnnotation

Future<Task?> editTaskDialog(BuildContext context, {required Task parent, Task? task}) async {
  return await showModalBottomSheet<Task?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TaskEditView(task: task, parent: parent), context),
  );
}

class TaskEditView extends StatefulWidget {
  const TaskEditView({required this.parent, this.task});
  static String get routeName => 'task_edit';

  final Task parent;
  final Task? task;

  @override
  _TaskEditViewState createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  Task? get task => widget.task;
  Task get parent => widget.parent;
  bool get isNew => task == null;

  int? get _savedWsID => task?.workspaceId ?? parent.workspaceId;

  late TaskEditController controller;

  //TODO: валидация о заполненности работает неправильно, не сбрасывается после закрытия диалога
  // возможно, остаются tfa с теми же кодами для новых вьюх этого же контроллера и у них висит признак о произошедшем редактировании поля
  // была попытка использовать TFAnnotation для выбора статуса, чтобы реагировать на изменения поля в плане логики валидации
  @override
  void initState() {
    controller = TaskEditController();
    // TODO: это всё должно быть в инициализации контроллера!
    // TODO: Сам контроллер инициализировать по образу TaskViewController — передавать айдишник задачи

    controller.initState(tfaList: [
      TFAnnotation('title', label: loc.title, text: task?.title ?? ''),
      TFAnnotation('description', label: loc.description, text: task?.description ?? '', needValidate: false),
      TFAnnotation('startDate', label: loc.task_start_date_placeholder, noText: true, needValidate: false),
      TFAnnotation('dueDate', label: loc.task_due_date_placeholder, noText: true, needValidate: false),
    ]);

    controller.setStartDate(task?.startDate);
    controller.setDueDate(task?.dueDate);
    controller.selectWS(_savedWsID);
    controller.selectType(task?.type);
    // controller.setClosed(task?.closed);
    // controller.selectStatus(task?.status);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(BuildContext context, String code) {
    final ta = controller.tfAnnoForCode(code);
    final isDate = code.endsWith('Date');

    return ta.noText
        ? MTTextField.noText(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: isDate ? () => controller.selectDate(context, code) : null,
            prefixIcon: isDate ? const CalendarIcon() : null,
            suffixIcon: isDate && ta.text.isNotEmpty
                ? MTButton(
                    middle: Row(
                      children: [
                        Container(height: onePadding * 3, width: 1, color: borderColor.resolve(context)),
                        SizedBox(width: onePadding),
                        const CloseIcon(color: dangerColor),
                        SizedBox(width: onePadding),
                      ],
                    ),
                    onTap: () => controller.resetDate(code),
                  )
                : null,
          )
        : MTTextField(
            controller: controller.teControllers[code],
            label: ta.label,
            error: ta.errorText,
          );
  }

  /// общий виджет - форма с полями для задач и целей

  Widget form(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(children: [
        if (_savedWsID == null) controller.wsDropdown(context),
        ...['title', 'startDate', 'dueDate', 'description'].map((code) => textFieldForCode(context, code)),
        if (parent.isProject)
          MTButton(
            leading: DoneIcon(controller.isBacklog),
            titleText: loc.backlog,
            margin: tfPadding,
            onTap: controller.toggleBacklog,
          ),

        // ...[statuses],
        if (!isNew)
          MTButton.outlined(
            titleText: loc.delete_action_title,
            titleColor: dangerColor,
            margin: tfPadding.copyWith(top: onePadding * 4),
            onTap: () => controller.delete(context, task!),
          ),
        SizedBox(height: onePadding),
      ]),
    );
  }

  // List<Widget> get statuses => [
  //   if (controller.statuses.isNotEmpty)
  //     MTDropdown<Status>(
  //       onChanged: (status) => controller.selectStatus(status),
  //       value: controller.selectedStatus,
  //       items: controller.statuses,
  //       label: loc.task_status_placeholder,
  //     ),
  //   MTButton(
  //     leading: doneIcon(context, controller.closed),
  //     titleString: loc.state_closed,
  //     margin: tfPadding,
  //     onTap: () => controller.setClosed(!controller.closed),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          title: isNew ? parent.newSubtaskTitle : '',
          trailing: MTButton(
            titleText: loc.save_action_title,
            onTap: controller.validated ? () => controller.save(context, task: task, parent: parent) : null,
            margin: EdgeInsets.only(right: onePadding),
          ),
          bgColor: darkBackgroundColor,
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: form(context),
        ),
      ),
    );
  }
}
