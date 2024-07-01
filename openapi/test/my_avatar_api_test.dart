import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyAvatarApi
void main() {
  final instance = Openapi().getMyAvatarApi();

  group(MyAvatarApi, () {
    // Delete Avatar
    //
    //Future<MyUser> deleteAvatar() async
    test('test deleteAvatar', () async {
      // TODO
    });

    // Upload Avatar
    //
    //Future<MyUser> uploadAvatar(MultipartFile file) async
    test('test uploadAvatar', () async {
      // TODO
    });
  });
}
