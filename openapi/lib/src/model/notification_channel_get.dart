//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_channel_get.g.dart';

/// NotificationChannelGet
///
/// Properties:
/// * [id] 
/// * [code] 
@BuiltValue()
abstract class NotificationChannelGet implements Built<NotificationChannelGet, NotificationChannelGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  NotificationChannelGet._();

  factory NotificationChannelGet([void updates(NotificationChannelGetBuilder b)]) = _$NotificationChannelGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationChannelGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationChannelGet> get serializer => _$NotificationChannelGetSerializer();
}

class _$NotificationChannelGetSerializer implements PrimitiveSerializer<NotificationChannelGet> {
  @override
  final Iterable<Type> types = const [NotificationChannelGet, _$NotificationChannelGet];

  @override
  final String wireName = r'NotificationChannelGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationChannelGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationChannelGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationChannelGetBuilder result,
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
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationChannelGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationChannelGetBuilder();
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

