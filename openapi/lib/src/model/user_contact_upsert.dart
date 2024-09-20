//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_contact_upsert.g.dart';

/// UserContactUpsert
///
/// Properties:
/// * [id] 
/// * [value] 
/// * [userId] 
@BuiltValue()
abstract class UserContactUpsert implements Built<UserContactUpsert, UserContactUpsertBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'value')
  String get value;

  @BuiltValueField(wireName: r'user_id')
  int get userId;

  UserContactUpsert._();

  factory UserContactUpsert([void updates(UserContactUpsertBuilder b)]) = _$UserContactUpsert;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserContactUpsertBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserContactUpsert> get serializer => _$UserContactUpsertSerializer();
}

class _$UserContactUpsertSerializer implements PrimitiveSerializer<UserContactUpsert> {
  @override
  final Iterable<Type> types = const [UserContactUpsert, _$UserContactUpsert];

  @override
  final String wireName = r'UserContactUpsert';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserContactUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(String),
    );
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserContactUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserContactUpsertBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.value = valueDes;
          break;
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserContactUpsert deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserContactUpsertBuilder();
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

