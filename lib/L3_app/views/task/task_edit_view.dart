// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../components/close_dialog_button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import 'task_edit_controller.dart';

Future<Task?> showEditTaskDialog(BuildContext context, [ElementOfWork? selectedEW]) async {
  taskEditController.selectTask(selectedEW);

  return await showModalBottomSheet<Task?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => MTBottomSheet(TaskEditView(), context),
  );
}

class TaskEditView extends StatefulWidget {
  static String get routeName => 'task_edit';

  @override
  _TaskEditViewState createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  TaskEditController get _controller => taskEditController;
  ElementOfWork? get _ew => _controller.selectedEW;

  //TODO: валидация о заполненности работает неправильно, не сбрасывается после закрытия диалога
  // возможно, остаются tfa с теми же кодами для новых вьюх этого же контроллера и у них висит признак о произошедшем редактировании поля
  // была попытка использовать TFAnnotation для выбора статуса, чтобы реагировать на изменения поля в плане логики валидации
  @override
  void initState() {
    //TODO: возможно, это должно быть в инициализации контроллера?
    _controller.initState(tfaList: [
      TFAnnotation('title', label: loc.common_title, text: _ew?.title ?? ''),
      TFAnnotation('description', label: loc.common_description, text: _ew?.description ?? '', needValidate: false),
      TFAnnotation('dueDate', label: loc.ew_due_date_placeholder, noText: true, needValidate: false),
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: CloseDialogButton(),
          title: _ew == null ? loc.task_title_new : '',
          trailing: MTButton(
            loc.common_save_btn_title,
            _controller.validated ? () => _controller.save(context) : null,
            titleColor: _controller.validated ? mainColor : borderColor,
            padding: EdgeInsets.only(right: onePadding),
          ),
        ),
        body: _controller.form(context, _controller.customFields(context)),
      ),
    );
  }
}
