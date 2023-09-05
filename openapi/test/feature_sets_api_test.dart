import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for FeatureSetsApi
void main() {
  final instance = Openapi().getFeatureSetsApi();

  group(FeatureSetsApi, () {
    // Feature Sets
    //
    //Future<BuiltList<FeatureSetGet>> featureSetsV1RefsFeatureSetsGet() async
    test('test featureSetsV1RefsFeatureSetsGet', () async {
      // TODO
    });
  });
}
