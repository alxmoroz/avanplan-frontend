// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
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
import 'widgets/dashboard/header_dashboard.dart';
import 'widgets/details/task_description_field.dart';
import 'widgets/details/task_details.dart';
import 'widgets/details/task_dialog_details.dart';
import 'widgets/empty_state/no_tasks.dart';
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
  double get _headerHeight => P8 + (_hasParent ? P6 : 0);

  double get _scrollOffsetTop => _isTaskDialog || !isBigScreen(context) ? _headerHeight : P4;

  @override
  void initState() {
    _scrollController = ScrollController();
    _boardScrollController = ScrollController();

    if (td.isGroup && task.creating) taskGroupToolbarController.setCompact(false);

    if (!td.filled) controller.reload(closed: false);

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

  Widget get _bodyContent => MTRefresh(
        onRefresh: () => controller.reload(closed: false),
        child: LayoutBuilder(
          builder: (ctx, size) => ListView(
            controller: isWeb ? _scrollController : null,
            children: [
              if (_isTaskDialog) const SizedBox(height: P8),

              /// Заголовок
              TaskHeader(controller),

              /// Описание
              if (task.isTask && (task.hasDescription || task.canEdit))
                TaskDescriptionField(controller, padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P)),

              /// Дашборд (аналитика, финансы, команда)
              if (task.isGroup || task.hasAnalytics || task.hasFinance || task.hasTeam) TaskHeaderDashboard(controller),

              /// Задача (лист)
              td.isTask
                  ? _isTaskDialog
                      ? TaskDialogDetails(controller)
                      : MTAdaptive(child: TaskDetails(controller))

                  /// Группа
                  : Observer(
                      builder: (_) => !task.hasSubtasks && (!task.canShowBoard || !controller.showBoard)

                          /// Группа без подзадач
                          ? NoTasks(controller)

                          /// Группа с задачами
                          : Observer(
                              builder: (_) => task.canShowBoard && controller.showBoard

                                  /// Доска
                                  ? Container(
                                      height: size.maxHeight - MediaQuery.paddingOf(ctx).vertical - (isBigScreen(context) ? _scrollOffsetTop : -P2),
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
                                  : TasksListView(task.subtaskGroups, extra: controller.loadClosedButton()),
                            ),
                    ),
            ],
          ),
        ),
      );

  Widget? get _title {
    return _isBigGroup
        ? MTAdaptive(
            padding: const EdgeInsets.symmetric(horizontal: P3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_hasParent) TaskParentTitle(controller),
                Container(
                  alignment: Alignment.centerLeft,
                  height: P8,
                  child: H1(task.title, maxLines: 1, height: 1.1, color: f2Color),
                ),
              ],
            ),
          )
        : Opacity(
            opacity: _hasScrolled ? 1 : 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_hasParent)
                  SmallText(
                    task.parent!.title,
                    maxLines: 1,
                    padding: const EdgeInsets.symmetric(horizontal: P6),
                  ),
                H3(task.title, maxLines: 1, padding: const EdgeInsets.symmetric(horizontal: P8)),
              ],
            ),
          );
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
    final big = isBigScreen(context);
    final body = SafeArea(
      top: false,
      bottom: false,
      child: big
          ? MediaQuery.removePadding(
              context: context,
              child: _bodyContent,
            )
          : _bodyContent,
    );
    return Observer(
      builder: (_) => controller.loading && !task.filled
          ? LoaderScreen(controller, isDialog: dialog)
          : dialog
              ? MTDialog(
                  topBar: MTAppBar(showCloseButton: true, color: b2Color, middle: _title),
                  body: body,
                  rightBar: _rightToolbar,
                  scrollController: _scrollController,
                  scrollOffsetTop: _scrollOffsetTop,
                  onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
                )
              : Observer(
                  builder: (_) {
                    final bigGroup = _isBigGroup;
                    final actions = controller.loading ? <TaskAction>[] : task.actions(context);
                    // TODO: определить как и fast / other actions в задаче
                    final showBottomToolbar = !bigGroup &&
                        (task.isTask || task.hasSubtasks || task.canShowBoard) &&
                        (task.canLocalImport || task.canCreateSubtask || task.canComment);

                    double bottomToolbarExtraHeight = 0.0;
                    if (showBottomToolbar && task.canComment) {
                      final style = const BaseText('', maxLines: 12).style(context);
                      final tp = TextPainter(
                        text: TextSpan(text: controller.fData(TaskFCode.note.index).text, style: style),
                        maxLines: 12,
                        textDirection: TextDirection.ltr,
                      );
                      tp.layout(maxWidth: MediaQuery.sizeOf(context).width - 141);
                      bottomToolbarExtraHeight = tp.height -
                          (style.fontSize ?? 0) +
                          (controller.attachmentsController.selectedFiles.isNotEmpty
                              ? P + (const SmallText('', maxLines: 1).style(context).fontSize ?? 0)
                              : 0);
                    }

                    return MTPage(
                      appBar: big && !_hasScrolled
                          ? null
                          : MTAppBar(
                              innerHeight: big ? _headerHeight : null,
                              color: bigGroup ? b2Color : null,
                              leading: bigGroup ? const SizedBox() : null,
                              middle: _title,
                              trailing: !bigGroup && controller.loading != true && actions.isNotEmpty ? TaskPopupMenu(controller, actions) : null,
                            ),
                      leftBar: big ? LeftMenu(leftMenuController) : null,
                      body: body,
                      bottomBar: showBottomToolbar ? TaskBottomToolbar(controller, extraHeight: bottomToolbarExtraHeight) : null,
                      // панель справа - для проекта и цели. Для инбокса только если он не пустой
                      rightBar: bigGroup && (!td.isInbox || task.hasSubtasks) ? _rightToolbar : null,
                      scrollController: _scrollController,
                      scrollOffsetTop: _scrollOffsetTop,
                      onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
                    );
                  },
                ),
    );
  }
}
