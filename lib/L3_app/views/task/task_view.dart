// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_params.dart';
import '../../../L1_domain/entities_extensions/task_type.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/barrier.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/page.dart';
import '../../components/page_title.dart';
import '../../components/refresh.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../components/toolbar_controller.dart';
import '../../presenters/task_actions.dart';
import '../../presenters/task_tree.dart';
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
import 'widgets/notes/note_field_toolbar_controller.dart';
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

class TaskViewState<T extends TaskView> extends State<T> with WidgetsBindingObserver, TickerProviderStateMixin {
  late final ScrollController scrollController;
  late final ScrollController _boardScrollController;
  late final TaskViewController _tvc;

  TaskController get tc => widget._tc;
  bool _hasScrolled = false;
  Task get td => tc.taskDescriptor;
  bool get _hasParent => td.parentId != null;

  bool get _isTaskDialog => isBigScreen(context) && td.isTask;
  bool get _isBigGroup => isBigScreen(context) && (td.isGroup || td.isInbox);
  double get headerHeight => P8 + (_hasParent ? P7 : 0);

  double get _scrollOffsetTop => _isTaskDialog || !isBigScreen(context) ? headerHeight : P4;

  bool _hasKB = false;

  bool get _titleFieldFocused => tc.focusNode(TaskFCode.title.index)?.hasFocus == true;
  bool get _descriptionFieldFocused => tc.focusNode(TaskFCode.description.index)?.hasFocus == true;
  bool get _noteFieldFocused => tc.focusNode(TaskFCode.note.index)?.hasFocus == true;
  bool get _showKBBarrier => _hasKB && (_titleFieldFocused || (_descriptionFieldFocused && !_isBigGroup));

  late final MTToolbarController _bottomTBController;
  late final NFToolbarController _bottomTBNFController;
  late final MTToolbarController _rightTBController;

  @override
  void initState() {
    scrollController = ScrollController();
    _boardScrollController = ScrollController();
    _tvc = TaskViewController();

    if (td.isGroup && tc.task.creating) groupRightToolbarController.setCompact(false);

    if (!td.filled) tc.reload(closed: false);

    _rightTBController = td.isTask
        ? taskRightToolbarController
        : td.isInbox
            ? rightToolbarController
            : groupRightToolbarController;

    _rightTBController.hidden = false;

    _bottomTBNFController = NFToolbarController(tc, _tvc);
    _bottomTBNFController.setupAnimation(this, () => setState(() {}));

    _bottomTBController = MTToolbarController();
    _bottomTBController.setupAnimation(this, () => setState(() {}));

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  bool _ignoreMetrics = false;
  double _prevBottomInset = 0;

  @override
  void didChangeMetrics() {
    // в движении - inset меньше или больше предыдущего
    // inset равен предыдущему -> остановилась
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    if (bottomInset != _prevBottomInset) {
      if (!_ignoreMetrics) {
        if (!_hasKB && bottomInset > _prevBottomInset) {
          setState(() => _hasKB = true);
          _toggleToolbars(true);
        } else if (_hasKB && bottomInset < _prevBottomInset) {
          setState(() => _hasKB = false);
          _toggleToolbars(false);
        }
      }
      // выставляем после блока сравнений
      _prevBottomInset = bottomInset;
    } else {
      _ignoreMetrics = ModalRoute.of(context)?.isCurrent != true;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tc.task.creating = false;

    scrollController.dispose();
    _boardScrollController.dispose();
    _bottomTBController.dispose();
    _bottomTBNFController.dispose();

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _toggleToolbars(bool hidden) {
    if (!_isTaskDialog) leftMenuController.setHidden(hidden);
    _rightTBController.setHidden(hidden);
    _bottomTBController.setHidden(hidden);
    if (!_noteFieldFocused) _bottomTBNFController.setHidden(hidden);
  }

  void onScrolled(bool scrolled) => setState(() => _hasScrolled = scrolled);

  // TODO: попробовать определять, что контент под тул-баром
  // bottomShadow: _showNoteToolbar || (_hasQuickActions && !_isBigGroup),

  Widget get _board => TasksBoard(tc, scrollController: _boardScrollController);

  Widget _bodyContent(Task t) => MTRefresh(
        onRefresh: () => tc.reload(closed: false),
        child: LayoutBuilder(builder: (ctx, bodySizeConstraints) {
          // доступная высота для полей ввода
          _tvc.setCenterConstraints(bodySizeConstraints.copyWith(maxHeight: bodySizeConstraints.maxHeight - headerHeight));
          final isTaskDialog = _isTaskDialog;
          return ListView(
            controller: isWeb ? scrollController : null,
            children: [
              /// Заголовок
              TaskHeader(tc),

              /// Описание
              if (t.isTask && (t.hasDescription || t.canEdit))
                TaskDescriptionField(tc, padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P2)),

              MTBarrier(
                visible: _showKBBarrier,
                inDialog: isTaskDialog,
                margin: EdgeInsets.only(top: td.isTask ? P3 : 0),
                child: Column(
                  children: [
                    /// Дашборд (аналитика, финансы, команда, вики-описание)
                    if (t.isGroup) TaskHeaderDashboard(tc),

                    if (tc.settingsController.hasFilteredAssignees) TaskAssigneeFilterChip(tc),

                    /// Задача (лист)
                    td.isTask
                        ? isTaskDialog
                            ? TaskDialogDetails(tc)
                            : MTAdaptive(child: TaskDetails(tc))

                        /// Группа
                        : !t.hasSubtasks && (!tc.settingsController.viewMode.isBoard)

                            /// Пустой список
                            ? NoTasks(tc)

                            /// Доска или не пустой список
                            : Observer(
                                builder: (_) => tc.settingsController.viewMode.isBoard

                                    /// Доска
                                    ? Container(
                                        height: bodySizeConstraints.maxHeight -
                                            MediaQuery.paddingOf(ctx).vertical -
                                            (isBigScreen(context) ? _scrollOffsetTop : -P2),
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

  Widget? topBarTitle(Task t) {
    return _isBigGroup
        ? t.hasSubtasks && tc.settingsController.viewMode.isBoard
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
            child: PageTitle(t.title, parentPageTitle: t.parent?.title),
          );
  }

  Widget _dialog(BuildContext context) {
    return Observer(builder: (_) {
      final t = tc.task;
      PreferredSizeWidget? bottomToolBar;
      if (tc.canComment) {
        _bottomTBNFController.calculateHeight(context, ignoreBottomInsets: true);
        bottomToolBar = NoteFieldToolbar(tc, _bottomTBNFController);
      }
      return MTDialog(
        topBar: MTTopBar(middle: topBarTitle(t)),
        body: _bodyContent(t),
        rightBar: TaskRightToolbar(tc, _rightTBController),
        bottomBar: bottomToolBar,
        scrollController: scrollController,
        scrollOffsetTop: headerHeight,
        onScrolled: onScrolled,
        hasKBInput: true,
      );
    });
  }

  Widget _page(BuildContext context) {
    return Observer(builder: (_) {
      final t = tc.task;
      final big = isBigScreen(context);
      final bigGroup = _isBigGroup;
      PreferredSizeWidget? bottomToolBar;
      if (tc.canComment) {
        _bottomTBNFController.calculateHeight(context, ignoreBottomInsets: false);
        bottomToolBar = NoteFieldToolbar(tc, _bottomTBNFController);
      } else if (!bigGroup &&
          t.hasSubtasks &&
          (tc.canLocalImport || t.canCreateSubtask || (t.isGroup && !tc.settingsController.viewMode.isProject))) {
        bottomToolBar = TaskBottomToolbar(tc, _bottomTBController);
      }

      return MTPage(
        key: widget.key,
        navBar: big && !_hasScrolled
            ? null
            : MTTopBar(
                innerHeight: big ? headerHeight : null,
                leading: bigGroup ? const SizedBox() : null,
                fullScreen: !big,
                color: big ? b2Color : navbarColor,
                middle: topBarTitle(t),
                trailing: !bigGroup && tc.loading != true ? TaskPopupMenu(tc) : null,
              ),
        leftBar: big ? LeftMenu(leftMenuController) : null,
        body: _bodyContent(t),
        bottomBar: bottomToolBar,
        // панель справа - для проекта и цели. Для инбокса только если он не пустой
        rightBar: bigGroup && (!td.isInbox || t.hasSubtasks) ? TaskRightToolbar(tc, _rightTBController) : null,
        scrollController: scrollController,
        scrollOffsetTop: _scrollOffsetTop,
        onScrolled: onScrolled,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final isDialog = _isTaskDialog;
      return tc.loading && !tc.task.filled
          ? LoaderScreen(tc, isDialog: isDialog)
          : isDialog
              ? _dialog(context)
              : _page(context);
    });
  }
}
