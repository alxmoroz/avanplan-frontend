//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_registration_token.g.dart';

/// BodyRegistrationToken
///
/// Properties:
/// * [token] 
@BuiltValue()
abstract class BodyRegistrationToken implements Built<BodyRegistrationToken, BodyRegistrationTokenBuilder> {
  @BuiltValueField(wireName: r'token')
  String get token;

  BodyRegistrationToken._();

  factory BodyRegistrationToken([void updates(BodyRegistrationTokenBuilder b)]) = _$BodyRegistrationToken;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyRegistrationTokenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyRegistrationToken> get serializer => _$BodyRegistrationTokenSerializer();
}

class _$BodyRegistrationTokenSerializer implements PrimitiveSerializer<BodyRegistrationToken> {
  @override
  final Iterable<Type> types = const [BodyRegistrationToken, _$BodyRegistrationToken];

  @override
  final String wireName = r'BodyRegistrationToken';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyRegistrationToken object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyRegistrationToken object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyRegistrationTokenBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyRegistrationToken deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyRegistrationTokenBuilder();
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

