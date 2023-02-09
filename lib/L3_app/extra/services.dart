// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../L1_domain/usecases/app_settings_uc.dart';
import '../../L1_domain/usecases/auth_uc.dart';
import '../../L1_domain/usecases/import_uc.dart';
import '../../L1_domain/usecases/my_uc.dart';
import '../../L1_domain/usecases/source_uc.dart';
import '../../L1_domain/usecases/task_uc.dart';
import '../../L1_domain/usecases/ws_settings_uc.dart';
import '../../L2_data/repositories/auth_apple_repo.dart';
import '../../L2_data/repositories/auth_google_repo.dart';
import '../../L2_data/repositories/auth_password_repo.dart';
import '../../L2_data/repositories/db_repo.dart';
import '../../L2_data/repositories/estimate_values_repo.dart';
import '../../L2_data/repositories/import_repo.dart';
import '../../L2_data/repositories/my_repo.dart';
import '../../L2_data/repositories/sources_repo.dart';
import '../../L2_data/repositories/tasks_repo.dart';
import '../../L2_data/repositories/ws_settings_repo.dart';
import '../../L2_data/services/api.dart';
import '../../L2_data/services/db.dart';
import '../l10n/generated/l10n.dart';
import '../views/account/account_controller.dart';
import '../views/import/import_controller.dart';
import '../views/loader/loader_controller.dart';
import '../views/main/main_controller.dart';
import '../views/notification/notification_controller.dart';
import '../views/references/references_controller.dart';
import '../views/settings/settings_controller.dart';
import '../views/source/source_controller.dart';
import 'auth/auth_controller.dart';
import 'router/link_controller.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

SettingsController get settingsController => GetIt.I<SettingsController>();
MainController get mainController => GetIt.I<MainController>();
LoaderController get loaderController => GetIt.I<LoaderController>();
SourceController get sourceController => GetIt.I<SourceController>();
ReferencesController get refsController => GetIt.I<ReferencesController>();
ImportController get importController => GetIt.I<ImportController>();
AccountController get accountController => GetIt.I<AccountController>();
AuthController get authController => GetIt.I<AuthController>();
NotificationController get notificationController => GetIt.I<NotificationController>();
LinkController get linkController => GetIt.I<LinkController>();

AppSettingsUC get appSettingsUC => GetIt.I<AppSettingsUC>();
WSSettingsUC get wsSettingsUC => GetIt.I<WSSettingsUC>();
AuthUC get authUC => GetIt.I<AuthUC>();
MyUC get myUC => GetIt.I<MyUC>();
TaskUC get taskUC => GetIt.I<TaskUC>();
SourceUC get sourceUC => GetIt.I<SourceUC>();
ImportUC get importUC => GetIt.I<ImportUC>();

void setup() {
  // device
  getIt.registerSingletonAsync<BaseDeviceInfo>(() async => await DeviceInfoPlugin().deviceInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  // repo / adapters
  getIt.registerSingletonAsync<HiveStorage>(() async => await HiveStorage().init());

  // global state controllers
  getIt.registerSingletonAsync<AuthController>(() async => AuthController().init(), dependsOn: [HiveStorage]);
  getIt.registerSingletonAsync<SettingsController>(() async => SettingsController().init(), dependsOn: [HiveStorage, PackageInfo]);
  getIt.registerSingleton<ReferencesController>(ReferencesController());
  getIt.registerSingleton<MainController>(MainController());
  getIt.registerSingleton<LoaderController>(LoaderController());
  getIt.registerSingleton<SourceController>(SourceController());
  getIt.registerSingleton<ImportController>(ImportController());
  getIt.registerSingleton<AccountController>(AccountController());
  getIt.registerSingleton<NotificationController>(NotificationController());
  getIt.registerSingleton<LinkController>(LinkController());

  // Openapi
  getIt.registerSingleton<Openapi>(setupApi([loaderController.interceptor]));

  // use cases
  getIt.registerSingleton<AuthUC>(AuthUC(
    passwordRepo: AuthPasswordRepo(),
    googleRepo: AuthGoogleRepo(),
    appleRepo: AuthAppleRepo(),
    localDBAuthRepo: LocalAuthRepo(),
  ));
  getIt.registerSingleton<AppSettingsUC>(AppSettingsUC(settingsRepo: SettingsRepo()));
  // getIt.registerSingleton<TaskTypesUC>(TaskTypesUC(repo: TaskTypesRepo()));
  getIt.registerSingleton<MyUC>(MyUC(repo: MyRepo()));
  getIt.registerSingleton<TaskUC>(TaskUC(repo: TasksRepo()));
  getIt.registerSingleton<SourceUC>(SourceUC(repo: SourcesRepo()));
  getIt.registerSingleton<ImportUC>(ImportUC(repo: ImportRepo()));
  getIt.registerSingleton<WSSettingsUC>(WSSettingsUC(settingsRepo: WSSettingsRepo(), estValueRepo: EstimateValueRepo()));
}
