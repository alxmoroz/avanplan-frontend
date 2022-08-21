// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../L1_domain/usecases/auth_uc.dart';
import '../../L1_domain/usecases/import_uc.dart';
import '../../L1_domain/usecases/settings_uc.dart';
import '../../L1_domain/usecases/sources_uc.dart';
import '../../L1_domain/usecases/tasks_uc.dart';
import '../../L1_domain/usecases/users_uc.dart';
import '../../L1_domain/usecases/workspaces_uc.dart';
import '../../L2_data/db.dart';
import '../../L2_data/repositories/auth_repo.dart';
import '../../L2_data/repositories/db_repo.dart';
import '../../L2_data/repositories/import_repo.dart';
import '../../L2_data/repositories/source_types_repo.dart';
import '../../L2_data/repositories/sources_repo.dart';
import '../../L2_data/repositories/tasks_repo.dart';
import '../../L2_data/repositories/users_repo.dart';
import '../../L2_data/repositories/workspaces_repo.dart';
import '../l10n/generated/l10n.dart';
import '../views/auth/login_controller.dart';
import '../views/import/import_controller.dart';
import '../views/main/main_controller.dart';
import '../views/settings/settings_controller.dart';
import '../views/source/source_controller.dart';
import '../views/user/user_controller.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

BaseDeviceInfo get deviceInfo => GetIt.I<BaseDeviceInfo>();
PackageInfo get packageInfo => GetIt.I<PackageInfo>();

SettingsController get settingsController => GetIt.I<SettingsController>();
LoginController get loginController => GetIt.I<LoginController>();
MainController get mainController => GetIt.I<MainController>();
SourceController get sourceController => GetIt.I<SourceController>();
ImportController get importController => GetIt.I<ImportController>();
UserController get userController => GetIt.I<UserController>();

Openapi get openAPI => GetIt.I<Openapi>();

SettingsUC get settingsUC => GetIt.I<SettingsUC>();
AuthUC get authUC => GetIt.I<AuthUC>();
WorkspacesUC get workspacesUC => GetIt.I<WorkspacesUC>();
TasksUC get tasksUC => GetIt.I<TasksUC>();
SourcesUC get sourcesUC => GetIt.I<SourcesUC>();
SourceTypesUC get sourceTypesUC => GetIt.I<SourceTypesUC>();
ImportUC get importUC => GetIt.I<ImportUC>();
UsersUC get usersUC => GetIt.I<UsersUC>();

void setup() {
  // device
  getIt.registerSingletonAsync<BaseDeviceInfo>(() async => await DeviceInfoPlugin().deviceInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  // repo / adapters
  getIt.registerSingletonAsync<HiveStorage>(() async => await HiveStorage().init());

  final api = Openapi(basePathOverride: 'https://gercul.es/api/');
  // final api = Openapi(basePathOverride: 'http://localhost:8000/');
  api.dio.options.connectTimeout = 300000;
  api.dio.options.receiveTimeout = 300000;
  getIt.registerSingleton<Openapi>(api);

  // use cases
  getIt.registerSingleton<AuthUC>(AuthUC(authRepo: AuthRepo(), localAuthRepo: LocalAuthRepo()));
  getIt.registerSingleton<SettingsUC>(SettingsUC(settingsRepo: SettingsRepo()));
  getIt.registerSingleton<WorkspacesUC>(WorkspacesUC(repo: WorkspacesRepo()));
  getIt.registerSingleton<TasksUC>(TasksUC(repo: TasksRepo()));
  getIt.registerSingleton<SourcesUC>(SourcesUC(repo: SourcesRepo()));
  getIt.registerSingleton<SourceTypesUC>(SourceTypesUC(repo: SourceTypesRepo()));
  getIt.registerSingleton<ImportUC>(ImportUC(repo: ImportRepo()));
  getIt.registerSingleton<UsersUC>(UsersUC(repo: UsersRepo()));

  // controllers
  getIt.registerSingletonAsync<LoginController>(() async => LoginController().init(), dependsOn: [HiveStorage]);
  getIt.registerSingleton<SettingsController>(SettingsController());
  getIt.registerSingleton<MainController>(MainController());
  getIt.registerSingleton<SourceController>(SourceController());
  getIt.registerSingleton<ImportController>(ImportController());
  getIt.registerSingleton<UserController>(UserController());
}
