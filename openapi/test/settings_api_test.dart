import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for SettingsApi
void main() {
  final instance = Openapi().getSettingsApi();

  group(SettingsApi, () {
    // Settings
    //
    //Future<AppSettingsGet> settingsV1SettingsGet() async
    test('test settingsV1SettingsGet', () async {
      // TODO
    });
  });
}
