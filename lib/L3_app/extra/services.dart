// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../L1_domain/usecases/auth_uc.dart';
import '../../L1_domain/usecases/goals_uc.dart';
import '../../L1_domain/usecases/import_uc.dart';
import '../../L1_domain/usecases/remote_trackers_uc.dart';
import '../../L1_domain/usecases/settings_uc.dart';
import '../../L1_domain/usecases/statuses_uc.dart';
import '../../L1_domain/usecases/tasks_uc.dart';
import '../../L1_domain/usecases/workspaces_uc.dart';
import '../../L2_data/db.dart';
import '../../L2_data/repositories/auth_repo.dart';
import '../../L2_data/repositories/db_repo.dart';
import '../../L2_data/repositories/goals_repo.dart';
import '../../L2_data/repositories/import_repo.dart';
import '../../L2_data/repositories/remote_tracker_types_repo.dart';
import '../../L2_data/repositories/remote_trackers_repo.dart';
import '../../L2_data/repositories/task_statuses_repo.dart';
import '../../L2_data/repositories/tasks_repo.dart';
import '../../L2_data/repositories/workspaces_repo.dart';
import '../l10n/generated/l10n.dart';
import '../views/auth/login_controller.dart';
import '../views/goal/goal_controller.dart';
import '../views/import/import_controller.dart';
import '../views/main/main_controller.dart';
import '../views/remote_tracker/tracker_controller.dart';
import '../views/settings/settings_controller.dart';
import '../views/task/task_edit_controller.dart';
import '../views/task/task_view_controller.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

BaseDeviceInfo get deviceInfo => GetIt.I<BaseDeviceInfo>();
PackageInfo get packageInfo => GetIt.I<PackageInfo>();

SettingsController get settingsController => GetIt.I<SettingsController>();
LoginController get loginController => GetIt.I<LoginController>();
MainController get mainController => GetIt.I<MainController>();
GoalController get goalController => GetIt.I<GoalController>();
TaskViewController get taskViewController => GetIt.I<TaskViewController>();
TaskEditController get taskEditController => GetIt.I<TaskEditController>();
TrackerController get trackerController => GetIt.I<TrackerController>();
ImportController get importController => GetIt.I<ImportController>();

Openapi get openAPI => GetIt.I<Openapi>();

SettingsUC get settingsUC => GetIt.I<SettingsUC>();
AuthUC get authUC => GetIt.I<AuthUC>();
WorkspacesUC get workspacesUC => GetIt.I<WorkspacesUC>();
GoalsUC get goalsUC => GetIt.I<GoalsUC>();
TaskStatusesUC get taskStatusesUC => GetIt.I<TaskStatusesUC>();
TasksUC get tasksUC => GetIt.I<TasksUC>();
RemoteTrackersUC get trackersUC => GetIt.I<RemoteTrackersUC>();
RemoteTrackerTypesUC get trackerTypesUC => GetIt.I<RemoteTrackerTypesUC>();
ImportUC get importUC => GetIt.I<ImportUC>();

void setup() {
  // device
  getIt.registerSingletonAsync<BaseDeviceInfo>(() async => await DeviceInfoPlugin().deviceInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  // repo / adapters
  getIt.registerSingletonAsync<HiveStorage>(() async => await HiveStorage().init());

  final api = Openapi();
  // final api = Openapi(basePathOverride: 'https://hercules.moroz.team/api/');
  // final api = Openapi(basePathOverride: 'http://localhost:8000/');
  api.dio.options.connectTimeout = 30000;
  api.dio.options.receiveTimeout = 30000;
  getIt.registerSingleton<Openapi>(api);

  // use cases
  getIt.registerSingleton<AuthUC>(AuthUC(authRepo: AuthRepo(), localAuthRepo: LocalAuthRepo()));
  getIt.registerSingleton<SettingsUC>(SettingsUC(settingsRepo: SettingsRepo()));
  getIt.registerSingleton<WorkspacesUC>(WorkspacesUC(repo: WorkspacesRepo()));
  getIt.registerSingleton<GoalsUC>(GoalsUC(repo: GoalsRepo()));
  getIt.registerSingleton<TasksUC>(TasksUC(repo: TasksRepo()));
  getIt.registerSingleton<TaskStatusesUC>(TaskStatusesUC(repo: TaskStatusesRepo()));
  getIt.registerSingleton<RemoteTrackersUC>(RemoteTrackersUC(repo: RemoteTrackersRepo()));
  getIt.registerSingleton<RemoteTrackerTypesUC>(RemoteTrackerTypesUC(repo: RemoteTrackerTypesRepo()));
  getIt.registerSingleton<ImportUC>(ImportUC(repo: ImportRepo()));

  // controllers
  getIt.registerSingletonAsync<LoginController>(() async => LoginController().init(), dependsOn: [HiveStorage]);
  getIt.registerSingletonAsync<SettingsController>(() async => SettingsController().init(), dependsOn: [HiveStorage, BaseDeviceInfo, PackageInfo]);
  getIt.registerSingleton<MainController>(MainController());
  getIt.registerSingleton<GoalController>(GoalController());
  getIt.registerSingleton<TaskViewController>(TaskViewController());
  getIt.registerSingleton<TaskEditController>(TaskEditController());
  getIt.registerSingleton<TrackerController>(TrackerController());
  getIt.registerSingleton<ImportController>(ImportController());
}
