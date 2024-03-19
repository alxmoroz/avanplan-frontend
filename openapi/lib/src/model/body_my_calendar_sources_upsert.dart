//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_my_calendar_sources_upsert.g.dart';

/// BodyMyCalendarSourcesUpsert
///
/// Properties:
/// * [email] 
/// * [sourceType] 
/// * [accessToken] 
@BuiltValue()
abstract class BodyMyCalendarSourcesUpsert implements Built<BodyMyCalendarSourcesUpsert, BodyMyCalendarSourcesUpsertBuilder> {
  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'source_type')
  String get sourceType;

  @BuiltValueField(wireName: r'access_token')
  String get accessToken;

  BodyMyCalendarSourcesUpsert._();

  factory BodyMyCalendarSourcesUpsert([void updates(BodyMyCalendarSourcesUpsertBuilder b)]) = _$BodyMyCalendarSourcesUpsert;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyMyCalendarSourcesUpsertBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyMyCalendarSourcesUpsert> get serializer => _$BodyMyCalendarSourcesUpsertSerializer();
}

class _$BodyMyCalendarSourcesUpsertSerializer implements PrimitiveSerializer<BodyMyCalendarSourcesUpsert> {
  @override
  final Iterable<Type> types = const [BodyMyCalendarSourcesUpsert, _$BodyMyCalendarSourcesUpsert];

  @override
  final String wireName = r'BodyMyCalendarSourcesUpsert';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyMyCalendarSourcesUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'source_type';
    yield serializers.serialize(
      object.sourceType,
      specifiedType: const FullType(String),
    );
    yield r'access_token';
    yield serializers.serialize(
      object.accessToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyMyCalendarSourcesUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyMyCalendarSourcesUpsertBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'source_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceType = valueDes;
          break;
        case r'access_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyMyCalendarSourcesUpsert deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyMyCalendarSourcesUpsertBuilder();
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

