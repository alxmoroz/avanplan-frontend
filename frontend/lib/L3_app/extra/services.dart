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
import '../views/workspace/workspace_controller.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

IosDeviceInfo get iosInfo => GetIt.I<IosDeviceInfo>();
PackageInfo get packageInfo => GetIt.I<PackageInfo>();

SettingsController get settingsController => GetIt.I<SettingsController>();
LoginController get loginController => GetIt.I<LoginController>();
WorkspaceController get workspaceController => GetIt.I<WorkspaceController>();
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
  getIt.registerSingletonAsync<IosDeviceInfo>(() async => await DeviceInfoPlugin().iosInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  // repo / adapters
  getIt.registerSingletonAsync<HiveStorage>(() async => await HiveStorage().init());
  getIt.registerSingletonAsync<Openapi>(() async {
    final api = Openapi(basePathOverride: 'http://localhost:8000/');
    // final api = Openapi(basePathOverride: 'https://hercules.moroz.team/api/');
    api.dio.options.connectTimeout = 30000;
    return api;
  });

  // use cases
  getIt.registerSingletonAsync<SettingsUC>(() async => SettingsUC(settingsRepo: SettingsRepo()));
  getIt.registerSingletonAsync<AuthUC>(() async => AuthUC(settingsUC: settingsUC, authRepo: AuthRepo()), dependsOn: [SettingsUC]);
  getIt.registerSingletonAsync<WorkspacesUC>(() async => WorkspacesUC(repo: WorkspacesRepo()));
  getIt.registerSingletonAsync<GoalsUC>(() async => GoalsUC(repo: GoalsRepo()));
  getIt.registerSingletonAsync<TasksUC>(() async => TasksUC(repo: TasksRepo()));
  getIt.registerSingletonAsync<TaskStatusesUC>(() async => TaskStatusesUC(repo: TaskStatusesRepo()));
  getIt.registerSingletonAsync<RemoteTrackersUC>(() async => RemoteTrackersUC(repo: RemoteTrackersRepo()));
  getIt.registerSingletonAsync<RemoteTrackerTypesUC>(() async => RemoteTrackerTypesUC(repo: RemoteTrackerTypesRepo()));
  getIt.registerSingletonAsync<ImportUC>(() async => ImportUC(repo: ImportRepo()));

  // controllers
  getIt.registerSingletonAsync<SettingsController>(() async => await SettingsController().init(), dependsOn: [HiveStorage, PackageInfo, SettingsUC]);
  getIt.registerSingletonAsync<LoginController>(() async => await LoginController().init(), dependsOn: [SettingsController, Openapi]);
  getIt.registerSingletonAsync<MainController>(() async => await MainController().init(), dependsOn: [LoginController]);
  getIt.registerSingletonAsync<WorkspaceController>(() async => await WorkspaceController().init(), dependsOn: [LoginController]);
  getIt.registerSingletonAsync<GoalController>(() async => await GoalController().init(), dependsOn: [LoginController]);
  getIt.registerSingletonAsync<TaskViewController>(() async => await TaskViewController().init(), dependsOn: [LoginController]);
  getIt.registerSingletonAsync<TaskEditController>(() async => await TaskEditController().init(), dependsOn: [LoginController]);
  getIt.registerSingletonAsync<TrackerController>(() async => await TrackerController().init(), dependsOn: [LoginController]);
  getIt.registerSingletonAsync<ImportController>(() async => await ImportController().init(), dependsOn: [LoginController]);
}
