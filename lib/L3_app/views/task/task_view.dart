// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
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
import '../../usecases/task_actions.dart';
import '../../usecases/task_tree.dart';
import 'controllers/task_controller.dart';
import 'widgets/details/task_details.dart';
import 'widgets/empty_state/no_tasks.dart';
import 'widgets/empty_state/not_found.dart';
import 'widgets/header/task_header.dart';
import 'widgets/header/task_popup_menu.dart';
import 'widgets/tasks/tasks_board.dart';
import 'widgets/tasks/tasks_list_view.dart';
import 'widgets/toolbar/task_toolbar.dart';

class TaskRouter extends MTRouter {
  static const _prefix = '/projects.*?';

  @override
  RegExp get pathRe => RegExp('^$_prefix/(\\d+)/(\\d+)\$');
  int get _wsId => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(1) ?? '-1');
  int get _taskId => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(2) ?? '-1');
  Task? get _task => tasksMainController.task(_wsId, _taskId);

  // TODO: костыль
  @override
  Widget? get page => rs!.arguments != null
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
  double get _headerHeight => P12 + (_hasParent ? P4 : 0);
  bool get _showBottomBar => task!.canComment || (task!.hasSubtasks && (task!.canShowBoard || task!.canLocalImport || task!.canCreate));

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

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return task != null
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                MTPage(
                  scrollController: _scrollController,
                  appBar: MTAppBar(
                    middle: _hasScrolled
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_hasParent) SmallText(task!.parent!.title, maxLines: 1),
                              H3(task!.title, maxLines: 1),
                            ],
                          )
                        : null,
                    trailing: task!.loading != true && task!.actionTypes.isNotEmpty
                        ? TaskPopupMenu(controller, icon: const MenuIcon())
                        : const SizedBox(width: P8),
                  ),
                  body: SafeArea(
                    top: false,
                    bottom: false,
                    // TODO: для большого экрана не нужна тень снизу
                    child: LayoutBuilder(builder: (ctx, size) {
                      final expandedHeight = size.maxHeight - MediaQuery.paddingOf(ctx).vertical;
                      return MTShadowed(
                        bottomShadow: _showBottomBar,
                        child: ListView(
                          children: [
                            TaskHeader(controller),
                            task!.isTask
                                ? TaskDetails(controller)
                                : !task!.hasSubtasks
                                    ? SizedBox(
                                        height: expandedHeight - _headerHeight,
                                        child: NoTasks(controller),
                                      )
                                    : Observer(
                                        builder: (_) => task!.canShowBoard && controller.showBoard
                                            ? SizedBox(
                                                height: expandedHeight - P4,
                                                child: TasksBoard(
                                                  controller.statusController,
                                                  extra: controller.subtasksController.loadClosedButton(board: true),
                                                ),
                                              )
                                            : TasksListView(
                                                task!.subtaskGroups,
                                                scrollable: false,
                                                extra: controller.subtasksController.loadClosedButton(),
                                              ),
                                      ),
                          ],
                        ),
                      );
                    }),
                  ),
                  bottomBar: _showBottomBar ? TaskToolbar(controller) : null,
                ),
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
