import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for RolesApi
void main() {
  final instance = Openapi().getRolesApi();

  group(RolesApi, () {
    // Roles
    //
    //Future<BuiltList<RoleGet>> rolesV1RolesGet(int wsId) async
    test('test rolesV1RolesGet', () async {
      // TODO
    });
  });
}
