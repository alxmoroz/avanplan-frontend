import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for SettingsApi
void main() {
  final instance = Openapi().getSettingsApi();

  group(SettingsApi, () {
    // Get Estimate Values
    //
    //Future<BuiltList<EstimateValueGet>> getEstimateValuesV1SettingsEstimateValuesGet(int wsId) async
    test('test getEstimateValuesV1SettingsEstimateValuesGet', () async {
      // TODO
    });

    // Get Settings
    //
    //Future<SettingsGet> getSettingsV1SettingsGet(int wsId) async
    test('test getSettingsV1SettingsGet', () async {
      // TODO
    });
  });
}
