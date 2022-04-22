// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:package_info/package_info.dart';

import '../../L1_domain/usecases/auth_uc.dart';
import '../../L1_domain/usecases/goals_uc.dart';
import '../../L1_domain/usecases/import_uc.dart';
import '../../L1_domain/usecases/remote_trackers_uc.dart';
import '../../L1_domain/usecases/settings_uc.dart';
import '../../L1_domain/usecases/statuses_uc.dart';
import '../../L1_domain/usecases/tasks_uc.dart';
import '../../L2_data/db.dart';
import '../../L2_data/repositories/auth_repo.dart';
import '../../L2_data/repositories/db_repo.dart';
import '../../L2_data/repositories/goal_statuses_repo.dart';
import '../../L2_data/repositories/goals_repo.dart';
import '../../L2_data/repositories/import_repo.dart';
import '../../L2_data/repositories/remote_tracker_types_repo.dart';
import '../../L2_data/repositories/remote_trackers_repo.dart';
import '../../L2_data/repositories/task_statuses_repo.dart';
import '../../L2_data/repositories/tasks_repo.dart';
import '../l10n/generated/l10n.dart';
import '../views/auth/login_controller.dart';
import '../views/goal/goal_edit_controller.dart';
import '../views/import/import_controller.dart';
import '../views/main/main_controller.dart';
import '../views/remote_tracker/tracker_controller.dart';
import '../views/task/task_edit_controller.dart';
import '../views/task/task_view_controller.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

IosDeviceInfo get iosInfo => GetIt.I<IosDeviceInfo>();
PackageInfo get packageInfo => GetIt.I<PackageInfo>();

LoginController get loginController => GetIt.I<LoginController>();
MainController get mainController => GetIt.I<MainController>();
GoalEditController get goalEditController => GetIt.I<GoalEditController>();
TaskViewController get taskViewController => GetIt.I<TaskViewController>();
TaskEditController get taskEditController => GetIt.I<TaskEditController>();
TrackerController get trackerController => GetIt.I<TrackerController>();
ImportController get importController => GetIt.I<ImportController>();

Openapi get openAPI => GetIt.I<Openapi>();

AuthUC get authUC => GetIt.I<AuthUC>();
GoalsUC get goalsUC => GetIt.I<GoalsUC>();
GoalStatusesUC get goalStatusesUC => GetIt.I<GoalStatusesUC>();
TaskStatusesUC get taskStatusesUC => GetIt.I<TaskStatusesUC>();
TasksUC get tasksUC => GetIt.I<TasksUC>();
RemoteTrackersUC get trackersUC => GetIt.I<RemoteTrackersUC>();
RemoteTrackerTypesUC get trackerTypesUC => GetIt.I<RemoteTrackerTypesUC>();
ImportUC get importUC => GetIt.I<ImportUC>();

SettingsUC get settingsUC => GetIt.I<SettingsUC>();

void setup() {
  // device
  getIt.registerSingletonAsync<IosDeviceInfo>(() async => await DeviceInfoPlugin().iosInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  // repo / adapters
  getIt.registerSingletonAsync<HiveStorage>(() async => await HiveStorage().init());
  getIt.registerSingletonAsync<Openapi>(() async {
    // final api = Openapi(basePathOverride: 'http://localhost:8000/');
    final api = Openapi(basePathOverride: 'https://hercules.moroz.team/api/');
    api.dio.options.connectTimeout = 10000;
    return api;
  });

  // use cases
  getIt.registerSingletonAsync<SettingsUC>(() async => SettingsUC(settingsRepo: SettingsRepo()));
  getIt.registerSingletonAsync<AuthUC>(() async => AuthUC(settingsUC: settingsUC, authRepo: AuthRepo()), dependsOn: [SettingsUC]);
  getIt.registerSingletonAsync<GoalsUC>(() async => GoalsUC(repo: GoalsRepo()), dependsOn: [AuthUC]);
  getIt.registerSingletonAsync<TasksUC>(() async => TasksUC(repo: TasksRepo()), dependsOn: [AuthUC]);
  getIt.registerSingletonAsync<GoalStatusesUC>(() async => GoalStatusesUC(repo: GoalStatusesRepo()), dependsOn: [AuthUC]);
  getIt.registerSingletonAsync<TaskStatusesUC>(() async => TaskStatusesUC(repo: TaskStatusesRepo()), dependsOn: [AuthUC]);
  getIt.registerSingletonAsync<RemoteTrackersUC>(() async => RemoteTrackersUC(repo: RemoteTrackersRepo()), dependsOn: [AuthUC]);
  getIt.registerSingletonAsync<RemoteTrackerTypesUC>(() async => RemoteTrackerTypesUC(repo: RemoteTrackerTypesRepo()), dependsOn: [AuthUC]);
  getIt.registerSingletonAsync<ImportUC>(() async => ImportUC(repo: ImportRepo()), dependsOn: [AuthUC]);

  // controllers
  getIt.registerSingletonAsync<MainController>(
    () async => await MainController().init(),
    dependsOn: [HiveStorage, PackageInfo, IosDeviceInfo, Openapi, SettingsUC, AuthUC, GoalsUC],
  );
  getIt.registerSingletonAsync<LoginController>(() async => await LoginController().init(), dependsOn: [MainController]);
  getIt.registerSingletonAsync<GoalEditController>(() async => await GoalEditController().init(), dependsOn: [MainController]);
  getIt.registerSingletonAsync<TaskViewController>(() async => await TaskViewController().init(), dependsOn: [MainController]);
  getIt.registerSingletonAsync<TaskEditController>(() async => await TaskEditController().init(), dependsOn: [MainController]);
  getIt.registerSingletonAsync<TrackerController>(() async => await TrackerController().init(), dependsOn: [MainController]);
  getIt.registerSingletonAsync<ImportController>(() async => await ImportController().init(), dependsOn: [MainController]);
}
