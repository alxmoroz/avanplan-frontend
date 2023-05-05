import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyActivitiesApi
void main() {
  final instance = Openapi().getMyActivitiesApi();

  group(MyActivitiesApi, () {
    // Activities
    //
    //Future<BuiltList<UActivityGet>> activitiesV1MyActivitiesGet(String code) async
    test('test activitiesV1MyActivitiesGet', () async {
      // TODO
    });
  });
}
