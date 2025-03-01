//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_redeem_invitation.g.dart';

/// BodyRedeemInvitation
///
/// Properties:
/// * [invitationToken] 
@BuiltValue()
abstract class BodyRedeemInvitation implements Built<BodyRedeemInvitation, BodyRedeemInvitationBuilder> {
  @BuiltValueField(wireName: r'invitation_token')
  String get invitationToken;

  BodyRedeemInvitation._();

  factory BodyRedeemInvitation([void updates(BodyRedeemInvitationBuilder b)]) = _$BodyRedeemInvitation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyRedeemInvitationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyRedeemInvitation> get serializer => _$BodyRedeemInvitationSerializer();
}

class _$BodyRedeemInvitationSerializer implements PrimitiveSerializer<BodyRedeemInvitation> {
  @override
  final Iterable<Type> types = const [BodyRedeemInvitation, _$BodyRedeemInvitation];

  @override
  final String wireName = r'BodyRedeemInvitation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyRedeemInvitation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'invitation_token';
    yield serializers.serialize(
      object.invitationToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyRedeemInvitation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyRedeemInvitationBuilder result,
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
  BodyRedeemInvitation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyRedeemInvitationBuilder();
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

