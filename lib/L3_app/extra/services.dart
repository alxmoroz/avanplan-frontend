// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../L1_domain/usecases/attachment_uc.dart';
import '../../L1_domain/usecases/auth_uc.dart';
import '../../L1_domain/usecases/contract_uc.dart';
import '../../L1_domain/usecases/feature_set_uc.dart';
import '../../L1_domain/usecases/iap_uc.dart';
import '../../L1_domain/usecases/import_uc.dart';
import '../../L1_domain/usecases/invitation_uc.dart';
import '../../L1_domain/usecases/local_settings_uc.dart';
import '../../L1_domain/usecases/my_uc.dart';
import '../../L1_domain/usecases/note_uc.dart';
import '../../L1_domain/usecases/service_settings_uc.dart';
import '../../L1_domain/usecases/source_uc.dart';
import '../../L1_domain/usecases/tariff_uc.dart';
import '../../L1_domain/usecases/task_member_role_uc.dart';
import '../../L1_domain/usecases/task_uc.dart';
import '../../L1_domain/usecases/ws_uc.dart';
import '../../L2_data/repositories/attachment_repo.dart';
import '../../L2_data/repositories/auth_apple_repo.dart';
import '../../L2_data/repositories/auth_avanplan_repo.dart';
import '../../L2_data/repositories/auth_google_repo.dart';
import '../../L2_data/repositories/contract_repo.dart';
import '../../L2_data/repositories/db_repo.dart';
import '../../L2_data/repositories/feature_set_repo.dart';
import '../../L2_data/repositories/iap_repo.dart';
import '../../L2_data/repositories/import_repo.dart';
import '../../L2_data/repositories/invitation_repo.dart';
import '../../L2_data/repositories/my_repo.dart';
import '../../L2_data/repositories/note_repo.dart';
import '../../L2_data/repositories/service_settings_repo.dart';
import '../../L2_data/repositories/source_repo.dart';
import '../../L2_data/repositories/tariff_repo.dart';
import '../../L2_data/repositories/task_member_role_repo.dart';
import '../../L2_data/repositories/task_repo.dart';
import '../../L2_data/repositories/ws_repo.dart';
import '../../L2_data/services/api.dart';
import '../../L2_data/services/db.dart';
import '../l10n/generated/l10n.dart';
import '../views/account/account_controller.dart';
import '../views/auth/auth_controller.dart';
import '../views/iap/iap_controller.dart';
import '../views/loader/loader_controller.dart';
import '../views/main/controllers/main_controller.dart';
import '../views/main/controllers/tasks_main_controller.dart';
import '../views/main/controllers/ws_main_controller.dart';
import '../views/notification/notification_controller.dart';
import '../views/references/references_controller.dart';
import '../views/settings/local_settings_controller.dart';
import '../views/settings/service_settings_controller.dart';
import 'deep_link/deep_link_controller.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

LocalSettingsController get localSettingsController => GetIt.I<LocalSettingsController>();
ServiceSettingsController get serviceSettingsController => GetIt.I<ServiceSettingsController>();
MainController get mainController => GetIt.I<MainController>();
WSMainController get wsMainController => GetIt.I<WSMainController>();
TasksMainController get tasksMainController => GetIt.I<TasksMainController>();
LoaderController get loader => GetIt.I<LoaderController>();
ReferencesController get refsController => GetIt.I<ReferencesController>();
AccountController get accountController => GetIt.I<AccountController>();
AuthController get authController => GetIt.I<AuthController>();
NotificationController get notificationController => GetIt.I<NotificationController>();
DeepLinkController get deepLinkController => GetIt.I<DeepLinkController>();
IAPController get iapController => GetIt.I<IAPController>();

LocalSettingsUC get localSettingsUC => GetIt.I<LocalSettingsUC>();
ServiceSettingsUC get serviceSettingsUC => GetIt.I<ServiceSettingsUC>();
AuthUC get authUC => GetIt.I<AuthUC>();
MyUC get myUC => GetIt.I<MyUC>();
WorkspaceUC get workspaceUC => GetIt.I<WorkspaceUC>();
TaskUC get taskUC => GetIt.I<TaskUC>();
SourceUC get sourceUC => GetIt.I<SourceUC>();
ImportUC get importUC => GetIt.I<ImportUC>();
InvitationUC get invitationUC => GetIt.I<InvitationUC>();
TaskMemberRoleUC get taskMemberRoleUC => GetIt.I<TaskMemberRoleUC>();
InAppPurchaseUC get iapUC => GetIt.I<InAppPurchaseUC>();
TariffUC get tariffUC => GetIt.I<TariffUC>();
ContractUC get contractUC => GetIt.I<ContractUC>();
NoteUC get noteUC => GetIt.I<NoteUC>();
AttachmentUC get attachmentUC => GetIt.I<AttachmentUC>();
FeatureSetUC get featureSetUC => GetIt.I<FeatureSetUC>();

void setup() {
  // device
  getIt.registerSingletonAsync<BaseDeviceInfo>(() async => await DeviceInfoPlugin().deviceInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  // repo / adapters
  getIt.registerSingletonAsync<HiveStorage>(() async => await HiveStorage().init());

  // первый контроллер
  getIt.registerSingletonAsync<LocalSettingsController>(() async => LocalSettingsController().init(), dependsOn: [HiveStorage, PackageInfo]);

  // Openapi
  getIt.registerSingletonAsync<Openapi>(
    () async => await setupApi([loader.interceptor], localSettingsController.settings),
    dependsOn: [LocalSettingsController],
  );

  // use cases
  getIt.registerSingleton<AuthUC>(AuthUC(
    authAvanplanRepo: AuthAvanplanRepo(),
    googleRepo: AuthGoogleRepo(),
    appleRepo: AuthAppleRepo(),
    localDBAuthRepo: LocalAuthRepo(),
  ));
  getIt.registerSingleton<LocalSettingsUC>(LocalSettingsUC(LocalSettingsRepo()));
  getIt.registerSingleton<MyUC>(MyUC(MyRepo()));
  getIt.registerSingleton<WorkspaceUC>(WorkspaceUC(WSRepo()));
  getIt.registerSingleton<TaskUC>(TaskUC(TaskRepo()));
  getIt.registerSingleton<SourceUC>(SourceUC(SourceRepo()));
  getIt.registerSingleton<ImportUC>(ImportUC(ImportRepo()));
  getIt.registerSingleton<ServiceSettingsUC>(ServiceSettingsUC(ServiceSettingsRepo()));
  getIt.registerSingleton<InvitationUC>(InvitationUC(InvitationRepo()));
  getIt.registerSingleton<TaskMemberRoleUC>(TaskMemberRoleUC(TaskMemberRoleRepo()));
  getIt.registerSingleton<InAppPurchaseUC>(InAppPurchaseUC(IAPRepo()));
  getIt.registerSingleton<TariffUC>(TariffUC(TariffRepo()));
  getIt.registerSingleton<ContractUC>(ContractUC(ContractRepo()));
  getIt.registerSingleton<NoteUC>(NoteUC(NoteRepo()));
  getIt.registerSingleton<AttachmentUC>(AttachmentUC(AttachmentRepo()));
  getIt.registerSingleton<FeatureSetUC>(FeatureSetUC(FeatureSetRepo()));

  // global state controllers
  getIt.registerSingletonAsync<ServiceSettingsController>(() async => ServiceSettingsController().init(), dependsOn: [Openapi]);
  getIt.registerSingletonAsync<AuthController>(() async => AuthController().init(), dependsOn: [Openapi]);

  getIt.registerSingleton<ReferencesController>(ReferencesController());
  getIt.registerSingleton<MainController>(MainController());
  getIt.registerSingleton<WSMainController>(WSMainController());
  getIt.registerSingleton<TasksMainController>(TasksMainController());
  getIt.registerSingleton<LoaderController>(LoaderController());
  getIt.registerSingleton<AccountController>(AccountController());
  getIt.registerSingleton<NotificationController>(NotificationController());
  getIt.registerSingleton<DeepLinkController>(DeepLinkController());
  getIt.registerSingleton<IAPController>(IAPController());
}
