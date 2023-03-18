// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../L1_domain/usecases/app_settings_uc.dart';
import '../../L1_domain/usecases/auth_uc.dart';
import '../../L1_domain/usecases/contract_uc.dart';
import '../../L1_domain/usecases/import_uc.dart';
import '../../L1_domain/usecases/invitation_uc.dart';
import '../../L1_domain/usecases/local_settings_uc.dart';
import '../../L1_domain/usecases/my_uc.dart';
import '../../L1_domain/usecases/payment_uc.dart';
import '../../L1_domain/usecases/source_uc.dart';
import '../../L1_domain/usecases/tariff_uc.dart';
import '../../L1_domain/usecases/task_member_role_uc.dart';
import '../../L1_domain/usecases/task_uc.dart';
import '../../L2_data/repositories/app_settings_repo.dart';
import '../../L2_data/repositories/auth_apple_repo.dart';
import '../../L2_data/repositories/auth_google_repo.dart';
import '../../L2_data/repositories/auth_password_repo.dart';
import '../../L2_data/repositories/contract_repo.dart';
import '../../L2_data/repositories/db_repo.dart';
import '../../L2_data/repositories/import_repo.dart';
import '../../L2_data/repositories/invitation_repo.dart';
import '../../L2_data/repositories/my_repo.dart';
import '../../L2_data/repositories/payment_repo.dart';
import '../../L2_data/repositories/source_repo.dart';
import '../../L2_data/repositories/tariff_repo.dart';
import '../../L2_data/repositories/task_member_role_repo.dart';
import '../../L2_data/repositories/task_repo.dart';
import '../../L2_data/services/api.dart';
import '../../L2_data/services/db.dart';
import '../l10n/generated/l10n.dart';
import '../views/account/account_controller.dart';
import '../views/loader/loader_controller.dart';
import '../views/main/main_controller.dart';
import '../views/notification/notification_controller.dart';
import '../views/references/references_controller.dart';
import '../views/settings/settings_controller.dart';
import 'auth/auth_controller.dart';
import 'deep_link/deep_link_controller.dart';
import 'payment/payment_controller.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

SettingsController get settingsController => GetIt.I<SettingsController>();
MainController get mainController => GetIt.I<MainController>();
LoaderController get loaderController => GetIt.I<LoaderController>();
ReferencesController get refsController => GetIt.I<ReferencesController>();
AccountController get accountController => GetIt.I<AccountController>();
AuthController get authController => GetIt.I<AuthController>();
NotificationController get notificationController => GetIt.I<NotificationController>();
DeepLinkController get linkController => GetIt.I<DeepLinkController>();
PaymentController get paymentController => GetIt.I<PaymentController>();

LocalSettingsUC get localSettingsUC => GetIt.I<LocalSettingsUC>();
AppSettingsUC get appSettingsUC => GetIt.I<AppSettingsUC>();
AuthUC get authUC => GetIt.I<AuthUC>();
MyUC get myUC => GetIt.I<MyUC>();
TaskUC get taskUC => GetIt.I<TaskUC>();
SourceUC get sourceUC => GetIt.I<SourceUC>();
ImportUC get importUC => GetIt.I<ImportUC>();
InvitationUC get invitationUC => GetIt.I<InvitationUC>();
TaskMemberRoleUC get taskMemberRoleUC => GetIt.I<TaskMemberRoleUC>();
PaymentUC get paymentUC => GetIt.I<PaymentUC>();
TariffUC get tariffUC => GetIt.I<TariffUC>();
ContractUC get contractUC => GetIt.I<ContractUC>();

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
  getIt.registerSingleton<AccountController>(AccountController());
  getIt.registerSingleton<NotificationController>(NotificationController());
  getIt.registerSingleton<DeepLinkController>(DeepLinkController());
  getIt.registerSingleton<PaymentController>(PaymentController());

  // Openapi
  getIt.registerSingleton<Openapi>(setupApi([loaderController.interceptor]));

  // use cases
  getIt.registerSingleton<AuthUC>(AuthUC(
    passwordRepo: AuthPasswordRepo(),
    googleRepo: AuthGoogleRepo(),
    appleRepo: AuthAppleRepo(),
    localDBAuthRepo: LocalAuthRepo(),
  ));
  getIt.registerSingleton<LocalSettingsUC>(LocalSettingsUC(LocalSettingsRepo()));
  getIt.registerSingleton<MyUC>(MyUC(MyRepo()));
  getIt.registerSingleton<TaskUC>(TaskUC(TaskRepo()));
  getIt.registerSingleton<SourceUC>(SourceUC(SourceRepo()));
  getIt.registerSingleton<ImportUC>(ImportUC(ImportRepo()));
  getIt.registerSingleton<AppSettingsUC>(AppSettingsUC(AppSettingsRepo()));
  getIt.registerSingleton<InvitationUC>(InvitationUC(InvitationRepo()));
  getIt.registerSingleton<TaskMemberRoleUC>(TaskMemberRoleUC(TaskMemberRoleRepo()));
  getIt.registerSingleton<PaymentUC>(PaymentUC(PaymentRepo()));
  getIt.registerSingleton<TariffUC>(TariffUC(TariffRepo()));
  getIt.registerSingleton<ContractUC>(ContractUC(ContractRepo()));
}
