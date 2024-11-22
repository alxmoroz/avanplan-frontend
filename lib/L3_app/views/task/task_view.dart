// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_params.dart';
import '../../../L1_domain/entities_extensions/task_type.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/page.dart';
import '../../components/refresh.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../presenters/task_actions.dart';
import '../../presenters/task_tree.dart';
import '../../presenters/task_view.dart';
import '../_base/loader_screen.dart';
import '../main/main_view.dart';
import '../main/widgets/left_menu.dart';
import 'controllers/task_controller.dart';
import 'controllers/task_view_controller.dart';
import 'usecases/delete.dart';
import 'usecases/edit.dart';
import 'usecases/tree.dart';
import 'widgets/board/board.dart';
import 'widgets/dashboard/header_dashboard.dart';
import 'widgets/details/task_description_field.dart';
import 'widgets/details/task_details.dart';
import 'widgets/details/task_dialog_details.dart';
import 'widgets/empty_state/no_tasks.dart';
import 'widgets/header/parent_title.dart';
import 'widgets/header/task_header.dart';
import 'widgets/notes/note_field_toolbar.dart';
import 'widgets/tasks/tasks_list_view.dart';
import 'widgets/toolbars/bottom_toolbar.dart';
import 'widgets/toolbars/popup_menu.dart';
import 'widgets/toolbars/right_toolbar.dart';
import 'widgets/view_settings/assignee_filter_chip.dart';

class TaskView extends StatefulWidget {
  const TaskView(this._tc, {super.key});
  final TaskController _tc;

  @override
  State<TaskView> createState() => TaskViewState();
}

class TaskViewState<T extends TaskView> extends State<T> {
  late final ScrollController scrollController;
  late final ScrollController _boardScrollController;
  late final TaskViewController _tvController;

  TaskController get tc => widget._tc;
  bool _hasScrolled = false;
  Task get td => tc.taskDescriptor;
  bool get _hasParent => td.parentId != null;

  bool get _isTaskDialog => isBigScreen(context) && td.isTask;
  bool get _isBigGroup => isBigScreen(context) && (td.isGroup || td.isInbox);
  double get headerHeight => P8 + (_hasParent ? P7 : 0);

  double get _scrollOffsetTop => _isTaskDialog || !isBigScreen(context) ? headerHeight : P4;

  @override
  void initState() {
    scrollController = ScrollController();
    _boardScrollController = ScrollController();
    _tvController = TaskViewController();

    if (td.isGroup && tc.task.creating) taskGroupToolbarController.setCompact(false);

    if (!td.filled) tc.reload(closed: false);

    super.initState();
  }

  @override
  void dispose() {
    tc.task.creating = false;

    scrollController.dispose();
    _boardScrollController.dispose();
    super.dispose();
  }

  void onScrolled(bool scrolled) => setState(() => _hasScrolled = scrolled);

  // TODO: попробовать определять, что контент под тул-баром
  // bottomShadow: _showNoteToolbar || (_hasQuickActions && !_isBigGroup),

  Widget get _board => TasksBoard(tc, scrollController: _boardScrollController);

  Widget _bodyContent(Task t) => MTRefresh(
        onRefresh: () => tc.reload(closed: false),
        child: LayoutBuilder(builder: (ctx, constraints) {
          // доступная высота для полей ввода
          _tvController.setCenterConstraints(constraints.copyWith(maxHeight: constraints.maxHeight - headerHeight));

          return ListView(
            controller: isWeb ? scrollController : null,
            children: [
              /// Заголовок
              TaskHeader(tc),

              /// Описание
              if (t.isTask && (t.hasDescription || t.canEdit))
                TaskDescriptionField(tc, padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P2)),

              /// Дашборд (аналитика, финансы, команда)
              if (t.isGroup || t.hasAnalytics || t.hasFinance || t.hasTeam) TaskHeaderDashboard(tc),

              if (tc.settingsController.hasFilteredAssignees) TaskAssigneeFilterChip(tc),

              /// Задача (лист)
              td.isTask
                  ? _isTaskDialog
                      ? TaskDialogDetails(tc)
                      : MTAdaptive(child: TaskDetails(tc))

                  /// Группа
                  : !t.hasSubtasks

                      /// Группа без подзадач
                      ? NoTasks(tc)

                      /// Группа с задачами
                      : Observer(
                          builder: (_) => tc.settingsController.showBoard

                              /// Доска
                              ? Container(
                                  height:
                                      constraints.maxHeight - MediaQuery.paddingOf(ctx).vertical - (isBigScreen(context) ? _scrollOffsetTop : -P2),
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
                              : TasksListView(
                                  tc.filteredSubtaskGroups,
                                  onTaskDelete: (t) async => await TaskController(taskIn: t).delete(),
                                  extra: tc.loadClosedButton(),
                                ),
                        ),
            ],
          );
        }),
      );

  Widget _bigGroupTitle(Task t) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_hasParent) TaskParentTitle(tc),
          Container(
            alignment: Alignment.centerLeft,
            height: P8,
            child: H1(t.title, maxLines: 1, height: 1.1, color: f2Color),
          ),
        ],
      );

  Widget? toolbarTitle(Task t) {
    return _isBigGroup
        ? t.hasSubtasks && tc.settingsController.showBoard
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: P3),
                child: _bigGroupTitle(t),
              )
            : MTAdaptive(
                padding: const EdgeInsets.symmetric(horizontal: P3),
                child: _bigGroupTitle(t),
              )
        : Opacity(
            opacity: _hasScrolled ? 1 : 0,
            child: SubpageTitle(t.title, parentPageTitle: t.parent?.title),
          );
  }

  PreferredSizeWidget _rightToolbar(bool hasKB) {
    final tbController = td.isTask
        ? taskToolbarController
        : td.isInbox
            ? rightToolbarController
            : taskGroupToolbarController;
    tbController.setHidden(hasKB);

    return TaskRightToolbar(tc, tbController);
  }

  double _extraHeight(BuildContext context) => NoteFieldToolbar.calculateExtraHeight(context, tc, _tvController, _isTaskDialog);

  Widget _dialog(Task t, bool hasKB, bool showNoteField) {
    return MTDialog(
      topBar: MTTopBar(middle: toolbarTitle(t)),
      body: _bodyContent(t),
      rightBar: _rightToolbar(hasKB),
      bottomBar: showNoteField ? NoteFieldToolbar(tc, _tvController, ignoreBottomInsets: true, extraHeight: _extraHeight(context)) : null,
      scrollController: scrollController,
      scrollOffsetTop: _scrollOffsetTop,
      onScrolled: onScrolled,
    );
  }

  Widget _page(Task t, bool hasKB, bool showNoteField) {
    final big = isBigScreen(context);
    final bigGroup = _isBigGroup;
    PreferredSizeWidget? bottomToolBar;
    if (showNoteField) {
      bottomToolBar = NoteFieldToolbar(tc, _tvController, extraHeight: _extraHeight(context));
    } else if (!hasKB && !bigGroup && t.hasSubtasks && (t.canLocalImport || t.canCreateSubtask || t.canEditViewSettings)) {
      bottomToolBar = TaskBottomToolbar(tc);
    }

    leftMenuController.setHidden(hasKB);

    return MTPage(
      key: widget.key,
      navBar: big && !_hasScrolled
          ? null
          : MTTopBar(
              innerHeight: big ? headerHeight : null,
              leading: bigGroup ? const SizedBox() : null,
              fullScreen: !big,
              color: big ? b2Color : navbarColor,
              middle: toolbarTitle(t),
              trailing: !bigGroup && tc.loading != true ? TaskPopupMenu(tc) : null,
            ),
      leftBar: big ? LeftMenu(leftMenuController) : null,
      body: _bodyContent(t),
      bottomBar: bottomToolBar,
      // панель справа - для проекта и цели. Для инбокса только если он не пустой
      rightBar: bigGroup && (!td.isInbox || t.hasSubtasks) ? _rightToolbar(hasKB) : null,
      scrollController: scrollController,
      scrollOffsetTop: _scrollOffsetTop,
      onScrolled: onScrolled,
    );
  }

  Widget _content(BuildContext context, bool isDialog) {
    return Observer(builder: (_) {
      final t = tc.task;
      final hasKB = MediaQuery.viewInsetsOf(context).bottom > 0;
      final noteFieldFocused = tc.focusNode(TaskFCode.note.index)?.hasFocus == true;
      final showNoteField = t.canComment && (!hasKB || noteFieldFocused);

      return isDialog ? _dialog(t, hasKB, showNoteField) : _page(t, hasKB, showNoteField);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final isDialog = _isTaskDialog;
      return tc.loading && !tc.task.filled ? LoaderScreen(tc, isDialog: isDialog) : _content(context, isDialog);
    });
  }
}
