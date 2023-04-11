//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_redeem_invitation_v1_my_redeem_invitation_post.g.dart';

/// BodyRedeemInvitationV1MyRedeemInvitationPost
///
/// Properties:
/// * [invitationToken] 
@BuiltValue()
abstract class BodyRedeemInvitationV1MyRedeemInvitationPost implements Built<BodyRedeemInvitationV1MyRedeemInvitationPost, BodyRedeemInvitationV1MyRedeemInvitationPostBuilder> {
  @BuiltValueField(wireName: r'invitation_token')
  String? get invitationToken;

  BodyRedeemInvitationV1MyRedeemInvitationPost._();

  factory BodyRedeemInvitationV1MyRedeemInvitationPost([void updates(BodyRedeemInvitationV1MyRedeemInvitationPostBuilder b)]) = _$BodyRedeemInvitationV1MyRedeemInvitationPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyRedeemInvitationV1MyRedeemInvitationPostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyRedeemInvitationV1MyRedeemInvitationPost> get serializer => _$BodyRedeemInvitationV1MyRedeemInvitationPostSerializer();
}

class _$BodyRedeemInvitationV1MyRedeemInvitationPostSerializer implements PrimitiveSerializer<BodyRedeemInvitationV1MyRedeemInvitationPost> {
  @override
  final Iterable<Type> types = const [BodyRedeemInvitationV1MyRedeemInvitationPost, _$BodyRedeemInvitationV1MyRedeemInvitationPost];

  @override
  final String wireName = r'BodyRedeemInvitationV1MyRedeemInvitationPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyRedeemInvitationV1MyRedeemInvitationPost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.invitationToken != null) {
      yield r'invitation_token';
      yield serializers.serialize(
        object.invitationToken,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyRedeemInvitationV1MyRedeemInvitationPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyRedeemInvitationV1MyRedeemInvitationPostBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'invitation_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.invitationToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyRedeemInvitationV1MyRedeemInvitationPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyRedeemInvitationV1MyRedeemInvitationPostBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

