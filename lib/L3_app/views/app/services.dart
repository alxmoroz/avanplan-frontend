// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../L1_domain/usecases/attachments_uc.dart';
import '../../../L1_domain/usecases/auth_uc.dart';
import '../../../L1_domain/usecases/iap_uc.dart';
import '../../../L1_domain/usecases/invitation_uc.dart';
import '../../../L1_domain/usecases/local_settings_uc.dart';
import '../../../L1_domain/usecases/my_avatar_uc.dart';
import '../../../L1_domain/usecases/my_calendar_uc.dart';
import '../../../L1_domain/usecases/my_contacts_uc.dart';
import '../../../L1_domain/usecases/my_uc.dart';
import '../../../L1_domain/usecases/note_uc.dart';
import '../../../L1_domain/usecases/project_members_uc.dart';
import '../../../L1_domain/usecases/project_status_uc.dart';
import '../../../L1_domain/usecases/release_note_uc.dart';
import '../../../L1_domain/usecases/remote_sources_uc.dart';
import '../../../L1_domain/usecases/service_settings_uc.dart';
import '../../../L1_domain/usecases/task_local_settings_uc.dart';
import '../../../L1_domain/usecases/task_repeat_uc.dart';
import '../../../L1_domain/usecases/task_uc.dart';
import '../../../L1_domain/usecases/transaction_uc.dart';
import '../../../L1_domain/usecases/ws_my_uc.dart';
import '../../../L1_domain/usecases/ws_relations_uc.dart';
import '../../../L1_domain/usecases/ws_tariffs_uc.dart';
import '../../../L1_domain/usecases/ws_transfer_uc.dart';
import '../../../L1_domain/usecases/ws_uc.dart';
import '../../../L2_data/repositories/attachments_repo.dart';
import '../../../L2_data/repositories/auth_apple_repo.dart';
import '../../../L2_data/repositories/auth_avanplan_repo.dart';
import '../../../L2_data/repositories/auth_google_repo.dart';
import '../../../L2_data/repositories/auth_yandex_repo.dart';
import '../../../L2_data/repositories/db_repo.dart';
import '../../../L2_data/repositories/iap_repo.dart';
import '../../../L2_data/repositories/my_avatar_repo.dart';
import '../../../L2_data/repositories/my_calendar_repo.dart';
import '../../../L2_data/repositories/my_contacts_repo.dart';
import '../../../L2_data/repositories/my_repo.dart';
import '../../../L2_data/repositories/network_repo.dart';
import '../../../L2_data/repositories/notes_repo.dart';
import '../../../L2_data/repositories/project_invitations_repo.dart';
import '../../../L2_data/repositories/project_members_repo.dart';
import '../../../L2_data/repositories/project_statuses_repo.dart';
import '../../../L2_data/repositories/release_notes_repo.dart';
import '../../../L2_data/repositories/service_settings_repo.dart';
import '../../../L2_data/repositories/task_repeats_repo.dart';
import '../../../L2_data/repositories/task_repo.dart';
import '../../../L2_data/repositories/task_transactions_repo.dart';
import '../../../L2_data/repositories/ws_my_repo.dart';
import '../../../L2_data/repositories/ws_relations_repo.dart';
import '../../../L2_data/repositories/ws_repo.dart';
import '../../../L2_data/repositories/ws_sources_repo.dart';
import '../../../L2_data/repositories/ws_tariffs_repo.dart';
import '../../../L2_data/repositories/ws_transfer_repo.dart';
import '../../../L2_data/services/api.dart';
import '../../../L2_data/services/db.dart';
import '../../l10n/generated/l10n.dart';
import '../_base/api_interceptor.dart';
import '../auth/auth_controller.dart';
import '../calendar/calendar_controller.dart';
import '../main/controllers/main_controller.dart';
import '../main/controllers/tasks_local_settings_controller.dart';
import '../main/controllers/tasks_main_controller.dart';
import '../main/controllers/ws_main_controller.dart';
import '../my_account/my_account_controller.dart';
import '../notification/notification_controller.dart';
import '../references/references_controller.dart';
import 'app_controller.dart';
import 'local_settings_controller.dart';

S get loc => S.current;

final getIt = GetIt.I;

LocalSettingsController get localSettingsController => getIt<LocalSettingsController>();
TasksLocalSettingsController get tasksLocalSettingsController => getIt<TasksLocalSettingsController>();

AppController get appController => getIt<AppController>();
MainController get mainController => getIt<MainController>();
WSMainController get wsMainController => getIt<WSMainController>();
TasksMainController get tasksMainController => getIt<TasksMainController>();
ReferencesController get refsController => getIt<ReferencesController>();
MyAccountController get myAccountController => getIt<MyAccountController>();
AuthController get authController => getIt<AuthController>();
NotificationController get notificationController => getIt<NotificationController>();
CalendarController get calendarController => getIt<CalendarController>();

LocalSettingsUC get localSettingsUC => getIt<LocalSettingsUC>();
TasksLocalSettingsUC get tasksLocalSettingsUC => getIt<TasksLocalSettingsUC>();
ServiceSettingsUC get serviceSettingsUC => getIt<ServiceSettingsUC>();
AuthUC get authUC => getIt<AuthUC>();

MyUC get myUC => getIt<MyUC>();
MyCalendarUC get myCalendarUC => getIt<MyCalendarUC>();
MyContactsUC get myContactsUC => getIt<MyContactsUC>();
MyAvatarUC get myAvatarUC => getIt<MyAvatarUC>();

WorkspaceUC get wsUC => getIt<WorkspaceUC>();
WSTariffsUC get tariffsUC => getIt<WSTariffsUC>();
WSRelationsUC get relationsUC => getIt<WSRelationsUC>();
RemoteSourcesUC get remoteSourcesUC => getIt<RemoteSourcesUC>();
WSTransferUC get wsTransferUC => getIt<WSTransferUC>();
WSMyUC get wsMyUC => getIt<WSMyUC>();
InvitationUC get invitationUC => getIt<InvitationUC>();

ProjectStatusesUC get projectStatusesUC => getIt<ProjectStatusesUC>();
ProjectMembersUC get projectMembersUC => getIt<ProjectMembersUC>();

TaskUC get taskUC => getIt<TaskUC>();
TaskTransactionsUC get taskTransactionsUC => getIt<TaskTransactionsUC>();
TaskRepeatsUC get taskRepeatsUC => getIt<TaskRepeatsUC>();
NotesUC get notesUC => getIt<NotesUC>();
AttachmentsUC get attachmentsUC => getIt<AttachmentsUC>();

InAppPurchaseUC get iapUC => getIt<InAppPurchaseUC>();
ReleaseNotesUC get releaseNotesUC => getIt<ReleaseNotesUC>();

void setup() {
  /// device
  getIt.registerSingletonAsync<BaseDeviceInfo>(() async => await DeviceInfoPlugin().deviceInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  /// repo / adapters
  getIt.registerSingletonAsync<HiveStorage>(() async => await HiveStorage().init());

  /// use cases
  final lsRepo = LocalAuthRepo();
  getIt.registerSingleton<AuthUC>(AuthUC(
    networkRepo: NetworkRepo(),
    authAvanplanRepo: AuthAvanplanRepo(lsRepo),
    googleRepo: AuthGoogleRepo(lsRepo),
    appleRepo: AuthAppleRepo(lsRepo),
    yandexRepo: AuthYandexRepo(lsRepo),
  ));

  getIt.registerSingleton<LocalSettingsUC>(LocalSettingsUC(LocalSettingsRepo()));
  getIt.registerSingleton<TasksLocalSettingsUC>(TasksLocalSettingsUC(TaskLocalSettingsRepo()));

  getIt.registerSingleton<MyUC>(MyUC(MyRepo()));
  getIt.registerSingleton<MyCalendarUC>(MyCalendarUC(MyCalendarRepo()));
  getIt.registerSingleton<MyContactsUC>(MyContactsUC(MyContactsRepo()));
  getIt.registerSingleton<MyAvatarUC>(MyAvatarUC(MyAvatarRepo()));

  getIt.registerSingleton<WorkspaceUC>(WorkspaceUC(WSRepo()));
  getIt.registerSingleton<WSMyUC>(WSMyUC(WSMyRepo()));
  getIt.registerSingleton<RemoteSourcesUC>(RemoteSourcesUC(WSSourcesRepo()));
  getIt.registerSingleton<WSTariffsUC>(WSTariffsUC(WSTariffsRepo()));
  getIt.registerSingleton<WSRelationsUC>(WSRelationsUC(WSRelationsRepo()));
  getIt.registerSingleton<WSTransferUC>(WSTransferUC(WSTransferRepo()));

  getIt.registerSingleton<ProjectStatusesUC>(ProjectStatusesUC(ProjectStatusesRepo()));
  getIt.registerSingleton<ServiceSettingsUC>(ServiceSettingsUC(ServiceSettingsRepo()));
  getIt.registerSingleton<InvitationUC>(InvitationUC(ProjectInvitationsRepo()));
  getIt.registerSingleton<InAppPurchaseUC>(InAppPurchaseUC(IAPRepo()));
  getIt.registerSingleton<ReleaseNotesUC>(ReleaseNotesUC(ReleaseNotesRepo()));

  getIt.registerSingleton<TaskUC>(TaskUC(TaskRepo()));
  getIt.registerSingleton<ProjectMembersUC>(ProjectMembersUC(ProjectMembersRepo()));
  getIt.registerSingleton<TaskTransactionsUC>(TaskTransactionsUC(TaskTransactionsRepo()));
  getIt.registerSingleton<TaskRepeatsUC>(TaskRepeatsUC(TaskRepeatsRepo()));
  getIt.registerSingleton<NotesUC>(NotesUC(NotesRepo()));
  getIt.registerSingleton<AttachmentsUC>(AttachmentsUC(AttachmentsRepo()));

  /// global state controllers
  // первые контроллеры
  getIt.registerSingletonAsync<LocalSettingsController>(() async => LocalSettingsController().init(), dependsOn: [HiveStorage, PackageInfo]);
  getIt.registerSingletonAsync<TasksLocalSettingsController>(() async => TasksLocalSettingsController().init(), dependsOn: [HiveStorage]);

  // Openapi
  getIt.registerSingletonAsync<AvanplanApi>(
    () async => await setupApi([apiInterceptor], localSettingsController.settings),
    dependsOn: [LocalSettingsController],
  );

  // остальные контроллеры
  getIt.registerSingletonAsync<AuthController>(() async => AuthController().init(), dependsOn: [AvanplanApi]);
  getIt.registerSingleton<AppController>(AppController());
  getIt.registerSingleton<ReferencesController>(ReferencesController());
  getIt.registerSingleton<MainController>(MainController());
  getIt.registerSingleton<WSMainController>(WSMainController());
  getIt.registerSingleton<TasksMainController>(TasksMainController());
  getIt.registerSingleton<MyAccountController>(MyAccountController());
  getIt.registerSingleton<NotificationController>(NotificationController());
  getIt.registerSingleton<CalendarController>(CalendarController());
}
