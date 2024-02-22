// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../L2_data/services/platform.dart';
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
import 'widgets/actions/popup_menu.dart';
import 'widgets/actions/right_toolbar.dart';
import 'widgets/board/board.dart';
import 'widgets/details/task_details.dart';
import 'widgets/details/task_dialog_details.dart';
import 'widgets/empty_state/no_tasks.dart';
import 'widgets/empty_state/not_found.dart';
import 'widgets/header/header_dashboard.dart';
import 'widgets/header/parent_title.dart';
import 'widgets/header/task_header.dart';
import 'widgets/tasks/tasks_list_view.dart';

class TaskRouter extends MTRouter {
  static const _prefix = '/projects.*?';
  String _navPrefix(Task task) => task.isProject
      ? '/projects'
      : task.isGoal
          ? '/projects/goals'
          : task.isBacklog
              ? '/projects/backlogs'
              : '/projects/tasks';

  String _navPath(Task task) => '${_navPrefix(task)}/${task.wsId}/${task.id}';

  @override
  String path({Object? args}) => _navPath((args as TaskController).task!);

  @override
  bool get isDialog => isBigScreen(globalContext) && rs!.uri.path.startsWith('/projects/tasks');

  @override
  double get maxWidth => SCR_L_WIDTH;

  @override
  RegExp get pathRe => RegExp('^$_prefix/(\\d+)/(\\d+)\$');
  int get _wsId => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(1) ?? '-1');
  int get _taskId => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(2) ?? '-1');
  Task? get _task => tasksMainController.task(_wsId, _taskId);

  TaskController? get _rsArgsTaskController => rs!.arguments as TaskController?;
  // TODO: костыль
  @override
  Widget get page => rs?.arguments != null
      ? TaskView(_rsArgsTaskController!)
      : Observer(
          builder: (ctx) => loader.loading
              ? Container()
              : _task != null
                  ? TaskView(TaskController(_task!))
                  : const NotFoundPage(),
        );

  @override
  String get title => _rsArgsTaskController?.task?.viewTitle ?? '';

  Future navigateBreadcrumbs(BuildContext context, Task parent) async {
    final pName = (previousName ?? '');

    // переходим один раз назад в любом случае
    Navigator.of(context).pop();

    if (parent.isGoal) {
      // при переходе наверх в другую цель, меняем старого родителя на нового
      final previousTaskId = int.parse(pathRe.firstMatch(pName)?.group(2) ?? '-1');
      if (parent.isGoal && previousTaskId != parent.id) {
        await push(context, replace: true, args: TaskController(parent));
      }
    } else if (!pName.startsWith('/projects')) {
      // если переход из Мои задачи или с главной то нужно запушить родителя
      await push(context, args: TaskController(parent));
    }
  }
}

class TaskView extends StatefulWidget {
  // TODO: отвязаться от создания контроллера заранее. Создавать контроллер (инициализировать FData) нужно после загрузки данных,
  //  либо делать реиницилаизацию после загрузки данных.
  //  Кроме того, нужно отправлять сюда только айдишники
  const TaskView(this._controller, {super.key});
  final TaskController _controller;

  @override
  State<TaskView> createState() => TaskViewState();
}

class TaskViewState<T extends TaskView> extends State<T> {
  late final ScrollController _scrollController;
  late final ScrollController _boardScrollController;
  bool _hasScrolled = false;

  TaskController get controller => widget._controller;
  Task? get task => controller.task;
  bool get _hasParent => task?.parent != null;

  bool get _isTaskDialog => isBigScreen(context) && task!.isTask;
  bool get _isBigGroup => isBigScreen(context) && !task!.isTask;
  double get _headerHeight => P8 + (_hasParent ? P8 : 0);
  bool get _hasQuickActions => (task!.hasSubtasks && (task!.canShowBoard || task!.canLocalImport || task!.canCreate)) || task!.canComment;

  @override
  void initState() {
    if (isWeb) {
      setWebpageTitle(task?.viewTitle ?? '');
    }
    _scrollController = ScrollController();
    _boardScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    if (controller.allowDisposeFromView) {
      controller.subtasksController.dispose();
      controller.dispose();
    }
    _scrollController.dispose();
    _boardScrollController.dispose();
    super.dispose();
  }

  // TODO: попробовать определять, что контент под тул-баром
  // bottomShadow: _showNoteToolbar || (_hasQuickActions && !_isBigGroup),

  Widget get _board => TasksBoard(
        controller,
        scrollController: _boardScrollController,
      );

  Widget get _body => SafeArea(
        top: false,
        bottom: false,
        child: LayoutBuilder(builder: (ctx, size) {
          final expandedHeight = size.maxHeight - MediaQuery.paddingOf(ctx).vertical;
          return ListView(
            controller: isWeb ? _scrollController : null,
            children: [
              if (_isBigGroup && !_hasScrolled) SizedBox(height: _headerHeight),

              /// Заголовок
              Opacity(opacity: _hasScrolled ? 0 : 1, child: TaskHeader(controller)),

              /// Дашборд (аналитика, команда)
              if (task!.hasAnalytics || task!.hasTeam) TaskHeaderDashboard(controller),

              /// Задача (лист)
              task!.isTask
                  ? _isTaskDialog
                      ? TaskDialogDetails(controller)
                      : MTAdaptive(child: TaskDetails(controller))

                  /// Группа задач без подзадач
                  : !task!.hasSubtasks && !task!.canShowBoard
                      ? SizedBox(
                          // TODO: хардкод ((
                          height: expandedHeight - _headerHeight - (task!.hasAnalytics || task!.hasTeam ? 112 : 0),
                          child: NoTasks(controller),
                        )

                      /// Группа задач с задачами
                      : Observer(
                          builder: (_) => task!.canShowBoard && controller.showBoard

                              /// Доска
                              ? Container(
                                  height: expandedHeight + P2,
                                  padding: const EdgeInsets.only(top: P3),
                                  child: isWeb
                                      ? Scrollbar(
                                          controller: _boardScrollController,
                                          thumbVisibility: true,
                                          child: _board,
                                        )
                                      : _board,
                                )

                              /// Список
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

  Widget get _parentTitle => _isBigGroup
      ? TaskParentTitle(controller)
      : SmallText(
          task!.parent!.title,
          maxLines: 1,
          padding: const EdgeInsets.symmetric(horizontal: P6),
        );
  Widget? get _title => _hasScrolled
      ? Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: _isBigGroup ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
          children: [
            if (_hasParent) _parentTitle,
            _isBigGroup
                ? H1(task!.title, maxLines: 1, padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: _hasParent ? P : 0))
                : H3(task!.title, maxLines: 1, padding: const EdgeInsets.symmetric(horizontal: P6)),
          ],
        )
      : null;

  Widget _page(BuildContext context) {
    final big = isBigScreen(context);
    return _isTaskDialog
        ? MTDialog(
            topBar: MTAppBar(showCloseButton: true, color: b2Color, middle: _title, key: widget.key),
            body: _body,
            rightBar: TaskRightToolbar(controller.toolbarController),
            scrollController: _scrollController,
            scrollOffsetTop: _headerHeight,
            onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
          )
        : MTPage(
            appBar: big && !_hasScrolled
                ? null
                : MTAppBar(
                    key: widget.key,
                    innerHeight: big ? _headerHeight : null,
                    color: _isBigGroup ? b2Color : null,
                    leading: _isBigGroup ? const SizedBox() : null,
                    middle: _title,
                    trailing: !_isBigGroup && task!.loading != true && task!.actions(context).isNotEmpty ? TaskPopupMenu(controller) : null,
                  ),
            leftBar: big ? const LeftMenu() : null,
            body: _body,
            bottomBar: _hasQuickActions && !_isBigGroup ? TaskBottomToolbar(controller) : null,
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
