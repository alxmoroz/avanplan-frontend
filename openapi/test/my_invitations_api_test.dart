import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyInvitationsApi
void main() {
  final instance = Openapi().getMyInvitationsApi();

  group(MyInvitationsApi, () {
    // Redeem Invitation
    //
    //Future<ProjectGet> redeemInvitation(BodyRedeemInvitation bodyRedeemInvitation) async
    test('test redeemInvitation', () async {
      // TODO
    });
  });
}
