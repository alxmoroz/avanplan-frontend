import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for RolesApi
void main() {
  final instance = Openapi().getRolesApi();

  group(RolesApi, () {
    // Projects
    //
    //Future<BuiltList<RoleGet>> projectsV1RolesRolesGet(int wsId) async
    test('test projectsV1RolesRolesGet', () async {
      // TODO
    });
  });
}
