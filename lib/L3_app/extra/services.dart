// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../L1_domain/usecases/auth_uc.dart';
import '../../L1_domain/usecases/import_uc.dart';
import '../../L1_domain/usecases/my_uc.dart';
import '../../L1_domain/usecases/settings_uc.dart';
import '../../L1_domain/usecases/sources_uc.dart';
import '../../L1_domain/usecases/tasks_uc.dart';
import '../../L2_data/repositories/api.dart';
import '../../L2_data/repositories/auth_repo.dart';
import '../../L2_data/repositories/db.dart';
import '../../L2_data/repositories/db_repo.dart';
import '../../L2_data/repositories/import_repo.dart';
import '../../L2_data/repositories/my_repo.dart';
import '../../L2_data/repositories/source_types_repo.dart';
import '../../L2_data/repositories/sources_repo.dart';
import '../../L2_data/repositories/task_types_repo.dart';
import '../../L2_data/repositories/tasks_repo.dart';
import '../l10n/generated/l10n.dart';
import '../views/account/account_controller.dart';
import '../views/import/import_controller.dart';
import '../views/main/main_controller.dart';
import '../views/settings/settings_controller.dart';
import '../views/source/source_controller.dart';
import 'auth/auth_controller.dart';
import 'loader/loader_controller.dart';
import 'references/references_controller.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

SettingsController get settingsController => GetIt.I<SettingsController>();
MainController get mainController => GetIt.I<MainController>();
LoaderController get loaderController => GetIt.I<LoaderController>();
SourceController get sourceController => GetIt.I<SourceController>();
ReferencesController get referencesController => GetIt.I<ReferencesController>();
ImportController get importController => GetIt.I<ImportController>();
AccountController get accountController => GetIt.I<AccountController>();
AuthController get authController => GetIt.I<AuthController>();

SettingsUC get settingsUC => GetIt.I<SettingsUC>();
AuthUC get authUC => GetIt.I<AuthUC>();
MyUC get myUC => GetIt.I<MyUC>();
TasksUC get tasksUC => GetIt.I<TasksUC>();
SourcesUC get sourcesUC => GetIt.I<SourcesUC>();
SourceTypesUC get sourceTypesUC => GetIt.I<SourceTypesUC>();
TaskTypesUC get taskTypesUC => GetIt.I<TaskTypesUC>();
ImportUC get importUC => GetIt.I<ImportUC>();

void setup() {
  // device
  getIt.registerSingletonAsync<BaseDeviceInfo>(() async => await DeviceInfoPlugin().deviceInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  // repo / adapters
  getIt.registerSingletonAsync<HiveStorage>(() async => await HiveStorage().init());

  // use cases
  getIt.registerSingleton<AuthUC>(AuthUC(authRepo: AuthRepo(), localAuthRepo: LocalAuthRepo()));
  getIt.registerSingleton<SettingsUC>(SettingsUC(settingsRepo: SettingsRepo()));
  getIt.registerSingleton<TaskTypesUC>(TaskTypesUC(repo: TaskTypesRepo()));
  getIt.registerSingleton<MyUC>(MyUC(repo: MyRepo()));
  getIt.registerSingleton<TasksUC>(TasksUC(repo: TasksRepo()));
  getIt.registerSingleton<SourcesUC>(SourcesUC(repo: SourcesRepo()));
  getIt.registerSingleton<SourceTypesUC>(SourceTypesUC(repo: SourceTypesRepo()));
  getIt.registerSingleton<ImportUC>(ImportUC(repo: ImportRepo()));

  // global state controllers
  getIt.registerSingletonAsync<AuthController>(() async => AuthController().init(), dependsOn: [HiveStorage]);
  getIt.registerSingleton<SettingsController>(SettingsController());
  getIt.registerSingleton<ReferencesController>(ReferencesController());
  getIt.registerSingleton<MainController>(MainController());
  getIt.registerSingleton<LoaderController>(LoaderController());
  getIt.registerSingleton<SourceController>(SourceController());
  getIt.registerSingleton<ImportController>(ImportController());
  getIt.registerSingleton<AccountController>(AccountController());

  // Openapi
  getIt.registerSingleton<Openapi>(setupApi(loaderController.dioInterceptors));
}
