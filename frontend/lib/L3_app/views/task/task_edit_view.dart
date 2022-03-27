// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/task.dart';
import '../../components/bottom_sheet.dart';
import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/splash.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'task_edit_controller.dart';

//TODO: дубль по коду редактора цели! — ок, пока не определён способ использования этих компонентов. копипаст в данном случае оправдан

Future<Task?> showEditTaskDialog(BuildContext context, [Task? selectedTask]) async {
  taskEditController.selectTask(selectedTask);

  return await showModalBottomSheet<Task?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => MTBottomSheet(TaskEditView()),
  );
}

class TaskEditView extends StatefulWidget {
  static String get routeName => 'task_edit';

  @override
  _TaskEditViewState createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  TaskEditController get _controller => taskEditController;
  Task? get _task => _controller.selectedTask;
  Future<void>? _fetchStatuses;

  //TODO: валидация о заполненности работает неправильно, не сбрасывается после закрытия диалога
  // возможно, остаются tfa с теми же кодами для новых вьюх этого же контроллера и у них висит признак о произошедшем редактировании поля
  // была попытка использовать TFAnnotation для выбора статуса, чтобы реагировать на изменения поля в плане логики валидации
  @override
  void initState() {
    //TODO: возможно, это должно быть в инициализации контроллера?
    _controller.initState(tfaList: [
      TFAnnotation('title', label: loc.common_title, text: _task?.title ?? ''),
      TFAnnotation('description', label: loc.common_description, text: _task?.description ?? '', needValidate: false),
      TFAnnotation('dueDate', label: loc.common_due_date_placeholder, noText: true, needValidate: false),
    ]);

    _fetchStatuses = _controller.fetchStatuses();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // TODO: CupertinoPageScaffold и в заголовок кнопки
    return SafeArea(
      child: FutureBuilder(
        future: _fetchStatuses,
        builder: (_, snapshot) => snapshot.connectionState == ConnectionState.done
            ? Observer(
                builder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        H3(_task == null ? loc.task_title_new : '', align: TextAlign.center),
                        Row(
                          children: [
                            if (_controller.canEdit)
                              Button.icon(
                                deleteIcon(context),
                                () => _controller.delete(context),
                                padding: EdgeInsets.only(left: onePadding),
                              ),
                            const Spacer(),
                            Button(
                              loc.btn_save_title,
                              _controller.validated ? () => _controller.save(context) : null,
                              titleColor: _controller.validated ? mainColor : borderColor,
                              padding: EdgeInsets.only(right: onePadding),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _controller.form(context),
                  ],
                ),
              )
            : const SplashScreen(),
      ),
    );
  }
}
