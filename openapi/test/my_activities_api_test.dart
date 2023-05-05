import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyActivitiesApi
void main() {
  final instance = Openapi().getMyActivitiesApi();

  group(MyActivitiesApi, () {
    // Activities
    //
    //Future<BuiltList<UActivityGet>> activitiesV1MyActivitiesGet(BodyActivitiesV1MyActivitiesGet bodyActivitiesV1MyActivitiesGet) async
    test('test activitiesV1MyActivitiesGet', () async {
      // TODO
    });

    // Register
    //
    //Future<BuiltList<UActivityGet>> registerV1MyActivitiesRegisterPost(BodyRegisterV1MyActivitiesRegisterPost bodyRegisterV1MyActivitiesRegisterPost) async
    test('test registerV1MyActivitiesRegisterPost', () async {
      // TODO
    });
  });
}
