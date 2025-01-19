// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/next_task_or_event.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../../../components/images.dart';
import '../../../navigation/route.dart';
import '../../../navigation/router.dart';
import '../../../views/_base/loadable.dart';
import '../../../views/onboarding/onboarding_controller.dart';
import '../../../views/task/widgets/team/host_project_dialog.dart';
import '../../app/services.dart';

part 'main_controller.g.dart';

class MainController extends _Base with _$MainController {
  Future _reloadData() async {
    setLoaderScreenLoading();
    await myAccountController.reload();
    await refsController.reload();
    await notificationController.reload();
    await wsMainController.reload();
    await tasksMainController.reload();
    await calendarController.reload();

    _setUpdateDate(now);
  }

  Future reload() async => await load(_reloadData);

  @override
  startLoading() {
    setLoaderScreenLoading();
    super.startLoading();
  }

  // static const _updatePeriod = Duration(hours: 1);

  Future startup() async {
    await appController.startup();

    await authController.checkLocalAuth();
    if (authController.authorized) {
      TaskDescriptor? hostProject;
      // удаляем инфу о переходе по рекламе (передали в хедере)
      if (localSettingsController.hasUTM) await localSettingsController.deleteUTM();

      // определение возможного погашения приглашения для подключения к проекту
      if (localSettingsController.hasInvitation) {
        await load(() async {
          setLoaderScreen(titleText: loc.loader_invitation_redeem_title, imageName: ImageName.privacy.name);
          // TODO: на бэке предусмотрена логика погашения приглашения, сохраненного при регистрации.
          //  Т.е. если на фронте токена нет (другое устройство или сеанс), то это не помешает реализовать приглашение в проект после первой авторизации
          // TODO: в связи с этим вопрос: почему бы сразу не прикрепить человечка к проекту в момент запроса регистрации? Проблема безопасности?
          try {
            hostProject = await myUC.redeemInvitation(localSettingsController.invitationToken);
          } catch (_) {}

          await localSettingsController.deleteInvitationToken();
        });
      }

      // обновление данных
      final isTimeToUpdate = _updatedDate == null; // || _updatedDate!.add(_updatePeriod).isBefore(now);
      if (isTimeToUpdate || router.isDeepLink) {
        await reload();
      }

      // Онбординг
      String? onbPassedStepCode;
      if (!myAccountController.onboardingPassed) {
        onbPassedStepCode = await router.pushOnboarding(hostProject: hostProject);
      }

      // при наличии приглашения показываем диалог перехода к приглашающему проекту, если не было такого шага в онбординге
      if (hostProject != null && onbPassedStepCode != OnboardingStepCode.where_we_go.name) {
        await startWithHostProjectDialog(hostProject!);
      }

      // TODO: тут происходит запрос на отправку уведомлений. Наверное, это нужно перенести в онбординг
      // TODO: также тут происходит обработка сообщения из пуш-уведомления. Проверить логику, что это должно происходить в этом месте
      // Настройка пушей и обработка ссылок из пуша
      await notificationController.setup();
    } else {
      authController.signOut();
    }
  }

  void clear() {
    calendarController.clear();
    tasksMainController.clear();
    wsMainController.clear();
    notificationController.clear();
    refsController.clear();
    myAccountController.clear();

    _setUpdateDate(null);
  }

  List<MapEntry<TaskState, List<NextTaskOrEvent>>> get nextTasksOrEventsDateGroups {
    final nextTasksOrEvents = [
      ...tasksMainController.myTasks.map((t) => NextTaskOrEvent(t.dueDate, t)),
      ...calendarController.events.map((e) => NextTaskOrEvent(e.startDate, e)),
    ].sorted((n1, n2) => n1.compareTo(n2));

    final ge = groupBy<NextTaskOrEvent, TaskState>(nextTasksOrEvents, (nte) => nte.state);
    return ge.entries.sortedBy<num>((g) => g.key.index);
  }
}

abstract class _Base with Store, Loadable {
  @observable
  DateTime? _updatedDate;
  @action
  void _setUpdateDate(DateTime? dt) => _updatedDate = dt;

  @observable
  MTRoute? currentRoute;
  @action
  void setRoute(MTRoute? route) => currentRoute = route;
}
