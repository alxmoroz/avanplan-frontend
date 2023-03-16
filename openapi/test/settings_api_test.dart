import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for SettingsApi
void main() {
  final instance = Openapi().getSettingsApi();

  group(SettingsApi, () {
    // Get Settings
    //
    //Future<AppSettingsGet> getSettingsV1SettingsGet() async
    test('test getSettingsV1SettingsGet', () async {
      // TODO
    });
  });
}
