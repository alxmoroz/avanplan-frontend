// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
import '../../components/adaptive.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/error_sheet.dart';
import '../../components/icons.dart';
import '../../components/page.dart';
import '../../components/shadowed.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/task_type.dart';
import '../../presenters/task_view.dart';
import '../../usecases/task_actions.dart';
import '../../usecases/task_tree.dart';
import 'controllers/task_controller.dart';
import 'task_dialog.dart';
import 'widgets/details/task_details.dart';
import 'widgets/details/task_dialog_details.dart';
import 'widgets/empty_state/no_tasks.dart';
import 'widgets/empty_state/not_found.dart';
import 'widgets/header/task_header.dart';
import 'widgets/header/task_popup_menu.dart';
import 'widgets/tasks/tasks_board.dart';
import 'widgets/tasks/tasks_list_view.dart';
import 'widgets/toolbar/note_toolbar.dart';
import 'widgets/toolbar/task_bottom_toolbar.dart';
import 'widgets/toolbar/task_right_toolbar.dart';

class TaskRouter extends MTRouter {
  static const _prefix = '/projects.*?';

  @override
  bool get isDialog => _task?.isTask == true;

  @override
  RegExp get pathRe => RegExp('^$_prefix/(\\d+)/(\\d+)\$');
  int get _wsId => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(1) ?? '-1');
  int get _taskId => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(2) ?? '-1');
  Task? get _task => tasksMainController.task(_wsId, _taskId);

  // TODO: костыль
  @override
  Widget get page => rs?.arguments != null
      ? TaskView(rs!.arguments as TaskController)
      : Observer(
          builder: (ctx) => loader.loading
              ? Container()
              : _task != null
                  ? TaskView(TaskController(_task!))
                  : NotFoundPage(),
        );

  @override
  String get title => (rs!.arguments as TaskController?)?.task?.viewTitle ?? '';
  String _navPrefix(Task task) => task.isProject
      ? '/projects'
      : task.isGoal
          ? '/projects/goals'
          : task.isBacklog
              ? '/projects/backlogs'
              : '/projects/tasks';

  String _navPath(Task _task) => '${_navPrefix(_task)}/${_task.wsId}/${_task.id}';
  @override
  Future navigate(BuildContext context, {Object? args}) async => await Navigator.of(context).pushNamed(
        _navPath((args as TaskController).task!),
        arguments: args,
      );
}

class TaskView extends StatefulWidget {
  // TODO: отвязаться от создания контроллера заранее. Создавать контроллер (инициализировать FData) нужно после загрузки данных,
  //  либо делать реиницилаизацию после загрузки данных.
  //  Кроме того, нужно отправлять сюда только айдишники
  const TaskView(this._controller);
  final TaskController _controller;

  @override
  State<TaskView> createState() => TaskViewState();
}

class TaskViewState<T extends TaskView> extends State<T> {
  TaskController get controller => widget._controller;
  Task? get task => controller.task;
  bool get _hasParent => task?.parent != null;

  late final ScrollController _scrollController;
  bool _hasScrolled = false;

  bool get _isTaskDialog => isBigScreen && task!.isTask;
  bool get _isBigGroup => isBigScreen && !task!.isTask;
  double get _headerHeight => P12 + (_hasParent ? P4 : 0);
  bool get _hasQuickActions => task!.hasSubtasks && (task!.canShowBoard || task!.canLocalImport || task!.canCreate);
  bool get _showNoteToolbar => task!.canComment;

  @override
  void initState() {
    _scrollController = ScrollController();
    final offset = _headerHeight / 2;
    _scrollController.addListener(() {
      if ((!_hasScrolled && _scrollController.offset > offset) || (_hasScrolled && _scrollController.offset < offset)) {
        setState(() => _hasScrolled = !_hasScrolled);
      }
    });

    if (kIsWeb) {
      setWebpageTitle(task?.viewTitle ?? '');
    }

    super.initState();
  }

  @override
  void dispose() {
    if (controller.allowDisposeFromView) {
      controller.subtasksController.dispose();
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  double get _bottomPaddingIndent => P4;

  Widget get _body => LayoutBuilder(builder: (ctx, size) {
        final expandedHeight = size.maxHeight - MediaQuery.paddingOf(ctx).vertical;
        // TODO: для большого экрана не нужна тень снизу
        return MTShadowed(
          topShadow: _hasScrolled,
          topPaddingIndent: _isTaskDialog ? 0 : P,
          // TODO: попробовать определять, что контент под тул-баром
          bottomShadow: _showNoteToolbar || (_hasQuickActions && !_isBigGroup),
          bottomPaddingIndent: _bottomPaddingIndent,
          child: ListView(
            // shrinkWrap: false, //showSideMenu(context),
            children: [
              TaskHeader(controller),
              task!.isTask
                  ? MTAdaptive(child: _isTaskDialog ? TaskDialogDetails(controller) : TaskDetails(controller))
                  : !task!.hasSubtasks
                      ? SizedBox(
                          // TODO: хардкод ((
                          height: expandedHeight - _headerHeight - (task!.hasAnalytics || task!.hasTeam ? 150 : 0),
                          child: NoTasks(controller),
                        )
                      : Observer(
                          builder: (_) => task!.canShowBoard && controller.showBoard
                              ? Container(
                                  height: expandedHeight - _bottomPaddingIndent,
                                  padding: const EdgeInsets.only(top: P3),
                                  child: TasksBoard(
                                    controller.statusController,
                                    extra: controller.subtasksController.loadClosedButton(board: true),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.only(top: P3),
                                  child: TasksListView(
                                    task!.subtaskGroups,
                                    scrollable: false,
                                    extra: controller.subtasksController.loadClosedButton(),
                                  ),
                                ),
                        ),
            ],
          ),
        );
      });

  Widget get _parentTitle => _isBigGroup
      ? BaseText.f2(task!.parent!.title, maxLines: 1, padding: const EdgeInsets.symmetric(horizontal: P2))
      : SmallText(task!.parent!.title, maxLines: 1);
  Widget? get _title => _hasScrolled
      ? Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: _isBigGroup ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
          children: [
            if (_hasParent) _parentTitle,
            _isBigGroup ? H1(task!.title, maxLines: 1, padding: const EdgeInsets.symmetric(horizontal: P2)) : H3(task!.title, maxLines: 1),
          ],
        )
      : null;

  Widget get _page => _isTaskDialog
      ? TaskDialog(controller, _scrollController, _title, _body)
      : MTPage(
          scrollController: _scrollController,
          appBar: MTAppBar(
            height: _isBigGroup ? P10 : null,
            bgColor: _isBigGroup && _hasScrolled ? b2Color : null,
            leading: showSideMenu ? Container() : null,
            middle: _title,
            trailing: !_isBigGroup && task!.loading != true && task!.actionTypes.isNotEmpty
                ? TaskPopupMenu(
                    controller,
                    icon: const MenuIcon(),
                  )
                : null,
          ),
          body: SafeArea(top: false, bottom: false, child: _body),
          bottomBar: _showNoteToolbar
              ? NoteToolbar(controller)
              : _hasQuickActions && !_isBigGroup
                  ? TaskBottomToolbar(controller)
                  : null,
          rightBar: _isBigGroup ? TaskRightToolbar(controller) : null,
        );

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return task != null
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _page,
                if (task!.error != null)
                  MTErrorSheet(task!.error!, onClose: () {
                    task!.error = null;
                    tasksMainController.refreshTasks();
                  }),
              ],
            )
          : Container();
    });
  }
}
