//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_auth_google_token.g.dart';

/// BodyAuthGoogleToken
///
/// Properties:
/// * [googleToken] 
/// * [platform] 
@BuiltValue()
abstract class BodyAuthGoogleToken implements Built<BodyAuthGoogleToken, BodyAuthGoogleTokenBuilder> {
  @BuiltValueField(wireName: r'google_token')
  String get googleToken;

  @BuiltValueField(wireName: r'platform')
  String get platform;

  BodyAuthGoogleToken._();

  factory BodyAuthGoogleToken([void updates(BodyAuthGoogleTokenBuilder b)]) = _$BodyAuthGoogleToken;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyAuthGoogleTokenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyAuthGoogleToken> get serializer => _$BodyAuthGoogleTokenSerializer();
}

class _$BodyAuthGoogleTokenSerializer implements PrimitiveSerializer<BodyAuthGoogleToken> {
  @override
  final Iterable<Type> types = const [BodyAuthGoogleToken, _$BodyAuthGoogleToken];

  @override
  final String wireName = r'BodyAuthGoogleToken';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyAuthGoogleToken object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'google_token';
    yield serializers.serialize(
      object.googleToken,
      specifiedType: const FullType(String),
    );
    yield r'platform';
    yield serializers.serialize(
      object.platform,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyAuthGoogleToken object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyAuthGoogleTokenBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'google_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.googleToken = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.platform = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyAuthGoogleToken deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyAuthGoogleTokenBuilder();
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

