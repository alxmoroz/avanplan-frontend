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
import '../../components/icons.dart';
import '../../components/page.dart';
import '../../components/refresh.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../presenters/task_view.dart';
import '../../usecases/task_actions.dart';
import '../../usecases/task_tree.dart';
import '../_base/loader_screen.dart';
import '../main/main_view.dart';
import '../main/widgets/left_menu.dart';
import 'controllers/task_controller.dart';
import 'usecases/edit.dart';
import 'widgets/actions/bottom_toolbar.dart';
import 'widgets/actions/popup_menu.dart';
import 'widgets/actions/right_toolbar.dart';
import 'widgets/board/board.dart';
import 'widgets/details/task_details.dart';
import 'widgets/details/task_dialog_details.dart';
import 'widgets/empty_state/no_tasks.dart';
import 'widgets/header/header_dashboard.dart';
import 'widgets/header/parent_title.dart';
import 'widgets/header/task_header.dart';
import 'widgets/tasks/tasks_list_view.dart';

class TaskView extends StatefulWidget {
  const TaskView(this._controller, {super.key});
  final TaskController _controller;

  @override
  State<TaskView> createState() => TaskViewState();
}

class TaskViewState<T extends TaskView> extends State<T> {
  late final ScrollController _scrollController;
  late final ScrollController _boardScrollController;

  TaskController get controller => widget._controller;
  bool _hasScrolled = false;
  Task get task => controller.task;
  Task get td => controller.taskDescriptor;
  bool get _hasParent => task.parent != null;

  bool get _isTaskDialog => isBigScreen(context) && td.isTask;
  bool get _isBigGroup => isBigScreen(context) && (td.isGroup || td.isInbox);
  double get _headerHeight => P8 + (_hasParent ? P8 : 0);
  // TODO: определить как и fast / other actions в задаче
  bool get _hasQuickActions => (task.hasSubtasks && (task.canShowBoard || task.canLocalImport || task.canCreate)) || task.canComment;

  @override
  void initState() {
    _scrollController = ScrollController();
    _boardScrollController = ScrollController();

    if (!td.filled) controller.reload();

    super.initState();
  }

  @override
  void dispose() {
    task.creating = false;

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
              if (task.hasAnalytics || task.hasTeam) TaskHeaderDashboard(controller),

              /// Задача (лист)
              td.isTask
                  ? _isTaskDialog
                      ? TaskDialogDetails(controller)
                      : MTAdaptive(child: TaskDetails(controller))

                  /// Группа
                  : Observer(
                      builder: (_) => !task.hasSubtasks && !task.canShowBoard

                          /// Группа без подзадач
                          ? SizedBox(
                              // TODO: хардкод ((
                              height: expandedHeight - _headerHeight - (task.hasAnalytics || task.hasTeam ? 112 : 0),
                              child: NoTasks(controller),
                            )

                          /// Группа с задачами
                          : Observer(
                              builder: (_) => task.canShowBoard && controller.showBoard

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
                                      child: TasksListView(task.subtaskGroups),
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
          task.parent!.title,
          maxLines: 1,
          padding: const EdgeInsets.symmetric(horizontal: P6),
        );

  Widget? get _title {
    final textColor = td.isInbox ? f2Color : null;
    return _hasScrolled
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_hasParent) _parentTitle,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _isBigGroup ? P : P6).copyWith(top: _isBigGroup && _hasParent ? P : 0),
                child: Row(
                  mainAxisAlignment: _isBigGroup ? MainAxisAlignment.start : MainAxisAlignment.center,
                  children: [
                    if (td.isInbox) InboxIcon(color: f2Color, size: _isBigGroup ? P6 : P4),
                    SizedBox(width: _isBigGroup ? P2 : P),
                    Flexible(child: _isBigGroup ? H1(task.title, maxLines: 1, color: textColor) : H3(task.title, maxLines: 1, color: textColor)),
                  ],
                ),
              ),
            ],
          )
        : null;
  }

  TaskRightToolbar? get _rightToolbar => TaskRightToolbar(
        controller,
        td.isTask
            ? taskToolbarController
            : td.isInbox
                ? rightToolbarController
                : taskGroupToolbarController,
      );

  @override
  Widget build(BuildContext context) {
    final dialog = _isTaskDialog;
    return Observer(
      builder: (_) => controller.loading && !task.filled
          ? LoaderScreen(controller, isDialog: dialog)
          : dialog
              ? MTDialog(
                  topBar: MTAppBar(showCloseButton: true, color: b2Color, middle: _title),
                  body: _body,
                  rightBar: _rightToolbar,
                  scrollController: _scrollController,
                  scrollOffsetTop: _headerHeight,
                  onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
                )
              : Builder(
                  builder: (_) {
                    final big = isBigScreen(context);
                    final actions = controller.loading ? <TaskAction>[] : task.actions(context);
                    return Observer(
                      builder: (_) => MTPage(
                        appBar: big && !_hasScrolled
                            ? null
                            : MTAppBar(
                                innerHeight: big ? _headerHeight : null,
                                color: _isBigGroup ? b2Color : null,
                                leading: _isBigGroup ? const SizedBox() : null,
                                middle: _title,
                                trailing:
                                    !_isBigGroup && controller.loading != true && actions.isNotEmpty ? TaskPopupMenu(controller, actions) : null,
                              ),
                        leftBar: big ? LeftMenu(leftMenuController) : null,
                        body: MTRefresh(
                          onRefresh: controller.reload,
                          child: _body,
                        ),
                        bottomBar: !_isBigGroup && _hasQuickActions ? TaskBottomToolbar(controller) : null,
                        // панель справа - для проекта и цели. Для инбокса только если он не пустой
                        rightBar: _isBigGroup && (!td.isInbox || task.hasSubtasks) ? _rightToolbar : null,
                        scrollController: _scrollController,
                        scrollOffsetTop: _headerHeight,
                        onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
                      ),
                    );
                  },
                ),
    );
  }
}
