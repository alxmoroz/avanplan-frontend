import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for InvitationApi
void main() {
  final instance = Openapi().getInvitationApi();

  group(InvitationApi, () {
    // Create
    //
    //Future<String> createV1InvitationCreatePost(int wsId, Invitation invitation) async
    test('test createV1InvitationCreatePost', () async {
      // TODO
    });

    // Redeem
    //
    //Future<JsonObject> redeemV1InvitationRedeemPost(String url) async
    test('test redeemV1InvitationRedeemPost', () async {
      // TODO
    });
  });
}
