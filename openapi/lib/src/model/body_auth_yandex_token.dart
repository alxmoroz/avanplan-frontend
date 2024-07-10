//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_auth_yandex_token.g.dart';

/// BodyAuthYandexToken
///
/// Properties:
/// * [serverAuthCode] 
@BuiltValue()
abstract class BodyAuthYandexToken implements Built<BodyAuthYandexToken, BodyAuthYandexTokenBuilder> {
  @BuiltValueField(wireName: r'server_auth_code')
  String get serverAuthCode;

  BodyAuthYandexToken._();

  factory BodyAuthYandexToken([void updates(BodyAuthYandexTokenBuilder b)]) = _$BodyAuthYandexToken;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyAuthYandexTokenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyAuthYandexToken> get serializer => _$BodyAuthYandexTokenSerializer();
}

class _$BodyAuthYandexTokenSerializer implements PrimitiveSerializer<BodyAuthYandexToken> {
  @override
  final Iterable<Type> types = const [BodyAuthYandexToken, _$BodyAuthYandexToken];

  @override
  final String wireName = r'BodyAuthYandexToken';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyAuthYandexToken object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'server_auth_code';
    yield serializers.serialize(
      object.serverAuthCode,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyAuthYandexToken object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyAuthYandexTokenBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'server_auth_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.serverAuthCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyAuthYandexToken deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyAuthYandexTokenBuilder();
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

