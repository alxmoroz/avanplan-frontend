//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'u_notification_permission_get.g.dart';

/// UNotificationPermissionGet
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [channel] 
/// * [eventType] 
@BuiltValue()
abstract class UNotificationPermissionGet implements Built<UNotificationPermissionGet, UNotificationPermissionGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'user_id')
  int get userId;

  @BuiltValueField(wireName: r'channel')
  String get channel;

  @BuiltValueField(wireName: r'event_type')
  String get eventType;

  UNotificationPermissionGet._();

  factory UNotificationPermissionGet([void updates(UNotificationPermissionGetBuilder b)]) = _$UNotificationPermissionGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UNotificationPermissionGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UNotificationPermissionGet> get serializer => _$UNotificationPermissionGetSerializer();
}

class _$UNotificationPermissionGetSerializer implements PrimitiveSerializer<UNotificationPermissionGet> {
  @override
  final Iterable<Type> types = const [UNotificationPermissionGet, _$UNotificationPermissionGet];

  @override
  final String wireName = r'UNotificationPermissionGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UNotificationPermissionGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'channel';
    yield serializers.serialize(
      object.channel,
      specifiedType: const FullType(String),
    );
    yield r'event_type';
    yield serializers.serialize(
      object.eventType,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UNotificationPermissionGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UNotificationPermissionGetBuilder result,
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
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'channel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.channel = valueDes;
          break;
        case r'event_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.eventType = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UNotificationPermissionGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UNotificationPermissionGetBuilder();
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

