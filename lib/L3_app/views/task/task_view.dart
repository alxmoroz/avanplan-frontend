// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
import '../../components/adaptive.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/error_sheet.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/task_type.dart';
import '../../presenters/task_view.dart';
import '../../usecases/task_actions.dart';
import '../../usecases/task_tree.dart';
import '../main/widgets/left_menu.dart';
import 'controllers/task_controller.dart';
import 'widgets/actions/bottom_toolbar.dart';
import 'widgets/actions/note_toolbar.dart';
import 'widgets/actions/popup_menu.dart';
import 'widgets/actions/right_toolbar.dart';
import 'widgets/board/tasks_board.dart';
import 'widgets/details/task_details.dart';
import 'widgets/details/task_dialog_details.dart';
import 'widgets/empty_state/no_tasks.dart';
import 'widgets/empty_state/not_found.dart';
import 'widgets/header/parent_title.dart';
import 'widgets/header/task_header.dart';
import 'widgets/tasks/tasks_list_view.dart';

class TaskRouter extends MTRouter {
  static const _prefix = '/projects.*?';

  @override
  bool get isDialog => isBigScreen && rs!.uri.path.startsWith('/projects/tasks');

  @override
  double get maxWidth => SCR_L_WIDTH;

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
  Future pushNamed(BuildContext context, {Object? args}) async => await Navigator.of(context).pushNamed(
        _navPath((args as TaskController).task!),
        arguments: args,
      );

  Future navigateBreadcrumbs(BuildContext context, Task parent) async {
    // переходим назад
    Navigator.of(context).pop();

    // если переход из Мои задачи или с главной то нужно запушить родителя
    if (!(previousName ?? '').startsWith('/projects')) {
      await pushNamed(context, args: TaskController(parent));
    }
  }
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

  bool get _isTaskDialog => isBigScreen && task!.isTask;
  bool get _isBigGroup => isBigScreen && !task!.isTask;
  double get _headerHeight => P8 + (_hasParent ? P5 : 0);
  bool get _hasQuickActions => task!.hasSubtasks && (task!.canShowBoard || task!.canLocalImport || task!.canCreate);
  bool get _showNoteToolbar => task!.canComment;

  bool _hasScrolled = false;
  late final ScrollController _scrollController;

  @override
  void initState() {
    if (kIsWeb) {
      setWebpageTitle(task?.viewTitle ?? '');
    }
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    if (controller.allowDisposeFromView) {
      controller.subtasksController.dispose();
      controller.dispose();
    }
    super.dispose();
  }

  // double get _bottomPaddingIndent => P4;

  // TODO: попробовать определять, что контент под тул-баром
  // bottomShadow: _showNoteToolbar || (_hasQuickActions && !_isBigGroup),

  Widget _body(ScrollController scrollController) => SafeArea(
        top: false,
        bottom: false,
        child: LayoutBuilder(builder: (ctx, size) {
          final expandedHeight = size.maxHeight - MediaQuery.paddingOf(ctx).vertical;
          return ListView(
            controller: kIsWeb ? scrollController : null,
            children: [
              Opacity(opacity: _hasScrolled ? 0 : 1, child: TaskHeader(controller)),
              task!.isTask
                  ? _isTaskDialog
                      ? TaskDialogDetails(controller)
                      : MTAdaptive(child: TaskDetails(controller))
                  : !task!.hasSubtasks
                      ? SizedBox(
                          // TODO: хардкод ((
                          height: expandedHeight - _headerHeight - (task!.hasAnalytics || task!.hasTeam ? 112 : 0),
                          child: NoTasks(controller),
                        )
                      : Observer(
                          builder: (_) => task!.canShowBoard && controller.showBoard
                              ? Container(
                                  // height: expandedHeight - _bottomPaddingIndent + P_2,
                                  height: expandedHeight + P2,
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
          );
        }),
      );

  Widget get _parentTitle => _isBigGroup ? TaskParentTitle(controller) : SmallText(task!.parent!.title, maxLines: 1);
  Widget? get _title => _hasScrolled
      ? Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: _isBigGroup ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
          children: [
            if (_hasParent) _parentTitle,
            _isBigGroup
                ? H1(task!.title, maxLines: 1, padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: _hasParent ? P : 0))
                : H3(task!.title, maxLines: 1),
          ],
        )
      : null;

  Widget _page(BuildContext context) {
    return _isTaskDialog
        ? MTDialog(
            topBar: MTAppBar(showCloseButton: true, bgColor: b2Color, middle: _title),
            body: _body(_scrollController),
            rightBar: TaskRightToolbar(controller.toolbarController),
            bottomBar: task!.canComment ? NoteToolbar(controller) : null,
            scrollController: _scrollController,
            scrollOffsetTop: _headerHeight,
            onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
          )
        : MTPage(
            appBar: isBigScreen && !_hasScrolled
                ? null
                : MTAppBar(
                    height: isBigScreen ? _headerHeight : null,
                    paddingTop: isBigScreen ? P : 0,
                    bgColor: _isBigGroup ? b2Color : null,
                    leading: _isBigGroup ? const SizedBox() : null,
                    middle: _title,
                    trailing: !_isBigGroup && task!.loading != true && task!.actions.isNotEmpty ? TaskPopupMenu(controller) : null,
                  ),
            leftBar: const LeftMenu(),
            body: _body(_scrollController),
            bottomBar: _showNoteToolbar
                ? NoteToolbar(controller)
                : _hasQuickActions && !_isBigGroup
                    ? TaskBottomToolbar(controller)
                    : null,
            rightBar: _isBigGroup ? TaskRightToolbar(controller.toolbarController) : null,
            scrollController: _scrollController,
            scrollOffsetTop: _headerHeight,
            onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return task != null
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _page(context),
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
