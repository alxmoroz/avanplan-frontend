// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L2_data/services/environment.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/images.dart';
import '../../components/webview_dialog.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../views/_base/loadable.dart';

part 'auth_controller.g.dart';

class AuthController extends _AuthControllerBase with _$AuthController {
  AuthController() {
    stopLoading();
  }

  Future<AuthController> init() async {
    signInWithAppleIsAvailable = await authUC.appleIsAvailable();
    await authUC.googleIsAvailable();

    authorized = (await authUC.getLocalAuth()).hasToken;

    return this;
  }
}

abstract class _AuthControllerBase with Store, Loadable {
  @observable
  bool signInWithAppleIsAvailable = false;

  @observable
  bool authorized = false;

  @observable
  Uri? _yandexRedirectUri;

  @action
  void setYandexRedirectUri(Uri? uri) => _yandexRedirectUri = uri;

  @override
  void startLoading() {
    setLoaderScreen(imageName: ImageName.privacy.name, titleText: loc.loader_auth_title);
    super.startLoading();
  }

  @action
  Future _signInWithRegistration() async {
    if (authorized) await authUC.signOut();

    await load(() async {
      authorized = await authUC.signInWithRegistration(localSettingsController.registrationToken!);
      await localSettingsController.deleteRegistrationToken();
    });

    if (authorized) router.goMain();
  }

  @action
  Future signInWithPassword(String email, String pwd) async {
    await load(() async => authorized = await authUC.signInWithPassword(email, pwd));
    if (authorized) router.goMain();
  }

  @action
  Future signInGoogle() async {
    await load(() async => authorized = await authUC.signInGoogle());
    if (authorized) router.goMain();
  }

  @action
  Future signInApple() async {
    await load(() async => authorized = await authUC.signInApple());
    if (authorized) router.goMain();
  }

  @action
  Future signInYandex() async {
    await load(
      () async {
        if (_yandexRedirectUri == null) {
          final requestUri = authUC.yandexServerAuthCodeUri;
          if (isWeb) {
            await launchUrlString(requestUri.toString(), webOnlyWindowName: '_self');
          } else {
            _yandexRedirectUri = await showWebViewDialog(
              requestUri,
              onPageStartedExit: (url) => url.startsWith('$yandexOauthRedirectUri'),
            );
          }
        }

        if (_yandexRedirectUri != null) {
          final serverAuthCode = _yandexRedirectUri!.queryParameters['code'] ?? '';
          authorized = await authUC.signInYandex(serverAuthCode);
          _yandexRedirectUri = null;
        }
      },
    );
    if (authorized) router.goMain();
  }

  @action
  Future checkLocalAuth() async {
    final localAuth = await authUC.getLocalAuth();
    bool hasToken = localAuth.hasToken;
    if (hasToken && localAuth.needRefresh) {
      hasToken = await authUC.refreshToken();
    }
    authorized = hasToken;
  }

  @action
  Future signOut() async {
    router.goAuth();
    await authUC.signOut();
    authorized = false;
    mainController.clear();
  }

  Future startup() async {
    await appController.startup();
    if (localSettingsController.hasRegistration) {
      await _signInWithRegistration();
    } else if (_yandexRedirectUri != null) {
      await signInYandex();
    }
  }
}
