// Copyright (c) 2024. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../L1_domain/usecases/attachments_uc.dart';
import '../../L1_domain/usecases/auth_uc.dart';
import '../../L1_domain/usecases/iap_uc.dart';
import '../../L1_domain/usecases/invitation_uc.dart';
import '../../L1_domain/usecases/local_settings_uc.dart';
import '../../L1_domain/usecases/my_avatar_uc.dart';
import '../../L1_domain/usecases/my_calendar_uc.dart';
import '../../L1_domain/usecases/my_contacts_uc.dart';
import '../../L1_domain/usecases/my_uc.dart';
import '../../L1_domain/usecases/note_uc.dart';
import '../../L1_domain/usecases/project_members_uc.dart';
import '../../L1_domain/usecases/project_module_uc.dart';
import '../../L1_domain/usecases/project_status_uc.dart';
import '../../L1_domain/usecases/release_note_uc.dart';
import '../../L1_domain/usecases/remote_sources_uc.dart';
import '../../L1_domain/usecases/service_settings_uc.dart';
import '../../L1_domain/usecases/task_repeat_uc.dart';
import '../../L1_domain/usecases/task_uc.dart';
import '../../L1_domain/usecases/transaction_uc.dart';
import '../../L1_domain/usecases/ws_my_uc.dart';
import '../../L1_domain/usecases/ws_tariffs_uc.dart';
import '../../L1_domain/usecases/ws_transfer_uc.dart';
import '../../L1_domain/usecases/ws_uc.dart';
import '../../L2_data/repositories/attachments_repo.dart';
import '../../L2_data/repositories/auth_apple_repo.dart';
import '../../L2_data/repositories/auth_avanplan_repo.dart';
import '../../L2_data/repositories/auth_google_repo.dart';
import '../../L2_data/repositories/auth_yandex_repo.dart';
import '../../L2_data/repositories/db_repo.dart';
import '../../L2_data/repositories/iap_repo.dart';
import '../../L2_data/repositories/my_avatar_repo.dart';
import '../../L2_data/repositories/my_calendar_repo.dart';
import '../../L2_data/repositories/my_contacts_repo.dart';
import '../../L2_data/repositories/my_repo.dart';
import '../../L2_data/repositories/notes_repo.dart';
import '../../L2_data/repositories/project_invitations_repo.dart';
import '../../L2_data/repositories/project_members_repo.dart';
import '../../L2_data/repositories/project_modules_repo.dart';
import '../../L2_data/repositories/project_statuses_repo.dart';
import '../../L2_data/repositories/release_notes_repo.dart';
import '../../L2_data/repositories/service_settings_repo.dart';
import '../../L2_data/repositories/task_repeats_repo.dart';
import '../../L2_data/repositories/task_repo.dart';
import '../../L2_data/repositories/task_transactions_repo.dart';
import '../../L2_data/repositories/ws_my_repo.dart';
import '../../L2_data/repositories/ws_repo.dart';
import '../../L2_data/repositories/ws_sources_repo.dart';
import '../../L2_data/repositories/ws_tariffs_repo.dart';
import '../../L2_data/repositories/ws_transfer_repo.dart';
import '../../L2_data/services/api.dart';
import '../../L2_data/services/db.dart';
import '../l10n/generated/l10n.dart';
import '../views/_base/api_interceptor.dart';
import '../views/app/app_controller.dart';
import '../views/app/local_settings_controller.dart';
import '../views/auth/auth_controller.dart';
import '../views/calendar/calendar_controller.dart';
import '../views/main/controllers/main_controller.dart';
import '../views/main/controllers/tasks_main_controller.dart';
import '../views/main/controllers/ws_main_controller.dart';
import '../views/my_account/my_account_controller.dart';
import '../views/notification/notification_controller.dart';
import '../views/references/references_controller.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

LocalSettingsController get localSettingsController => GetIt.I<LocalSettingsController>();
AppController get appController => GetIt.I<AppController>();
MainController get mainController => GetIt.I<MainController>();
WSMainController get wsMainController => GetIt.I<WSMainController>();
TasksMainController get tasksMainController => GetIt.I<TasksMainController>();
ReferencesController get refsController => GetIt.I<ReferencesController>();
MyAccountController get myAccountController => GetIt.I<MyAccountController>();
AuthController get authController => GetIt.I<AuthController>();
NotificationController get notificationController => GetIt.I<NotificationController>();
CalendarController get calendarController => GetIt.I<CalendarController>();

LocalSettingsUC get localSettingsUC => GetIt.I<LocalSettingsUC>();
ServiceSettingsUC get serviceSettingsUC => GetIt.I<ServiceSettingsUC>();
AuthUC get authUC => GetIt.I<AuthUC>();

MyUC get myUC => GetIt.I<MyUC>();
MyCalendarUC get myCalendarUC => GetIt.I<MyCalendarUC>();
MyContactsUC get myContactsUC => GetIt.I<MyContactsUC>();
MyAvatarUC get myAvatarUC => GetIt.I<MyAvatarUC>();

WorkspaceUC get wsUC => GetIt.I<WorkspaceUC>();
WSTariffsUC get tariffsUC => GetIt.I<WSTariffsUC>();
RemoteSourcesUC get remoteSourcesUC => GetIt.I<RemoteSourcesUC>();
WSTransferUC get wsTransferUC => GetIt.I<WSTransferUC>();
WSMyUC get wsMyUC => GetIt.I<WSMyUC>();
InvitationUC get invitationUC => GetIt.I<InvitationUC>();

ProjectStatusesUC get projectStatusesUC => GetIt.I<ProjectStatusesUC>();
ProjectMembersUC get projectMembersUC => GetIt.I<ProjectMembersUC>();
ProjectModulesUC get projectModulesUC => GetIt.I<ProjectModulesUC>();

TaskUC get taskUC => GetIt.I<TaskUC>();
TaskTransactionsUC get taskTransactionsUC => GetIt.I<TaskTransactionsUC>();
TaskRepeatsUC get taskRepeatsUC => GetIt.I<TaskRepeatsUC>();
NotesUC get notesUC => GetIt.I<NotesUC>();
AttachmentsUC get attachmentsUC => GetIt.I<AttachmentsUC>();

InAppPurchaseUC get iapUC => GetIt.I<InAppPurchaseUC>();
ReleaseNotesUC get releaseNotesUC => GetIt.I<ReleaseNotesUC>();

void setup() {
  /// device
  getIt.registerSingletonAsync<BaseDeviceInfo>(() async => await DeviceInfoPlugin().deviceInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  /// repo / adapters
  getIt.registerSingletonAsync<HiveStorage>(() async => await HiveStorage().init());

  /// use cases
  getIt.registerSingleton<AuthUC>(AuthUC(
    authAvanplanRepo: AuthAvanplanRepo(),
    googleRepo: AuthGoogleRepo(),
    appleRepo: AuthAppleRepo(),
    yandexRepo: AuthYandexRepo(),
    localDBAuthRepo: LocalAuthRepo(),
  ));
  getIt.registerSingleton<LocalSettingsUC>(LocalSettingsUC(LocalSettingsRepo()));

  getIt.registerSingleton<MyUC>(MyUC(MyRepo()));
  getIt.registerSingleton<MyCalendarUC>(MyCalendarUC(MyCalendarRepo()));
  getIt.registerSingleton<MyContactsUC>(MyContactsUC(MyContactsRepo()));
  getIt.registerSingleton<MyAvatarUC>(MyAvatarUC(MyAvatarRepo()));

  getIt.registerSingleton<WorkspaceUC>(WorkspaceUC(WSRepo()));
  getIt.registerSingleton<WSMyUC>(WSMyUC(WSMyRepo()));
  getIt.registerSingleton<RemoteSourcesUC>(RemoteSourcesUC(WSSourcesRepo()));
  getIt.registerSingleton<WSTariffsUC>(WSTariffsUC(WSTariffsRepo()));
  getIt.registerSingleton<WSTransferUC>(WSTransferUC(WSTransferRepo()));

  getIt.registerSingleton<ProjectStatusesUC>(ProjectStatusesUC(ProjectStatusesRepo()));
  getIt.registerSingleton<ServiceSettingsUC>(ServiceSettingsUC(ServiceSettingsRepo()));
  getIt.registerSingleton<InvitationUC>(InvitationUC(ProjectInvitationsRepo()));
  getIt.registerSingleton<InAppPurchaseUC>(InAppPurchaseUC(IAPRepo()));
  getIt.registerSingleton<ProjectModulesUC>(ProjectModulesUC(ProjectModulesRepo()));
  getIt.registerSingleton<ReleaseNotesUC>(ReleaseNotesUC(ReleaseNotesRepo()));

  getIt.registerSingleton<TaskUC>(TaskUC(TaskRepo()));
  getIt.registerSingleton<ProjectMembersUC>(ProjectMembersUC(ProjectMembersRepo()));
  getIt.registerSingleton<TaskTransactionsUC>(TaskTransactionsUC(TaskTransactionsRepo()));
  getIt.registerSingleton<TaskRepeatsUC>(TaskRepeatsUC(TaskRepeatsRepo()));
  getIt.registerSingleton<NotesUC>(NotesUC(NotesRepo()));
  getIt.registerSingleton<AttachmentsUC>(AttachmentsUC(AttachmentsRepo()));

  /// global state controllers
  // первый контроллер
  getIt.registerSingletonAsync<LocalSettingsController>(() async => LocalSettingsController().init(), dependsOn: [HiveStorage, PackageInfo]);

  // Openapi
  getIt.registerSingletonAsync<Openapi>(
    () async => await setupApi([apiInterceptor], localSettingsController.settings),
    dependsOn: [LocalSettingsController],
  );
  getIt.registerSingletonAsync<AuthController>(() async => AuthController().init(), dependsOn: [Openapi]);
  getIt.registerSingleton<AppController>(AppController());
  getIt.registerSingleton<ReferencesController>(ReferencesController());
  getIt.registerSingleton<MainController>(MainController());
  getIt.registerSingleton<WSMainController>(WSMainController());
  getIt.registerSingleton<TasksMainController>(TasksMainController());
  getIt.registerSingleton<MyAccountController>(MyAccountController());
  getIt.registerSingleton<NotificationController>(NotificationController());
  getIt.registerSingleton<CalendarController>(CalendarController());
}
