//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_auth_token_google_oauth.g.dart';

/// BodyAuthTokenGoogleOauth
///
/// Properties:
/// * [googleToken] 
@BuiltValue()
abstract class BodyAuthTokenGoogleOauth implements Built<BodyAuthTokenGoogleOauth, BodyAuthTokenGoogleOauthBuilder> {
  @BuiltValueField(wireName: r'google_token')
  String get googleToken;

  BodyAuthTokenGoogleOauth._();

  factory BodyAuthTokenGoogleOauth([void updates(BodyAuthTokenGoogleOauthBuilder b)]) = _$BodyAuthTokenGoogleOauth;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyAuthTokenGoogleOauthBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyAuthTokenGoogleOauth> get serializer => _$BodyAuthTokenGoogleOauthSerializer();
}

class _$BodyAuthTokenGoogleOauthSerializer implements PrimitiveSerializer<BodyAuthTokenGoogleOauth> {
  @override
  final Iterable<Type> types = const [BodyAuthTokenGoogleOauth, _$BodyAuthTokenGoogleOauth];

  @override
  final String wireName = r'BodyAuthTokenGoogleOauth';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyAuthTokenGoogleOauth object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'google_token';
    yield serializers.serialize(
      object.googleToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyAuthTokenGoogleOauth object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyAuthTokenGoogleOauthBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyAuthTokenGoogleOauth deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyAuthTokenGoogleOauthBuilder();
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

