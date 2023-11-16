// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter_apns_only/flutter_apns_only.dart';

// https://github.com/mwaylabs/flutter-apns/blob/master/flutter_apns_only/lib/flutter_apns_only.dart

Future<ApnsPushConnectorOnly> getApnsTokenConnector({
  ApnsMessageHandler? onLaunch,
  ApnsMessageHandler? onResume,
  ApnsMessageHandler? onMessage,
  ApnsMessageHandler? onBackgroundMessage,
}) async {
  final connector = ApnsPushConnectorOnly();
  connector.configureApns(
    onLaunch: onLaunch,
    onResume: onResume,
    onMessage: onMessage,
    onBackgroundMessage: onBackgroundMessage,
  );

  await connector.requestNotificationPermissions();

  return connector;
}
