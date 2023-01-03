//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/user_get.dart';
import 'package:openapi/src/model/event_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'event_message_get.g.dart';

/// EventMessageGet
///
/// Properties:
/// * [id] 
/// * [isRead] 
/// * [event] 
/// * [recipient] 
@BuiltValue()
abstract class EventMessageGet implements Built<EventMessageGet, EventMessageGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'is_read')
  bool? get isRead;

  @BuiltValueField(wireName: r'event')
  EventGet get event;

  @BuiltValueField(wireName: r'recipient')
  UserGet get recipient;

  EventMessageGet._();

  factory EventMessageGet([void updates(EventMessageGetBuilder b)]) = _$EventMessageGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EventMessageGetBuilder b) => b
      ..isRead = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<EventMessageGet> get serializer => _$EventMessageGetSerializer();
}

class _$EventMessageGetSerializer implements PrimitiveSerializer<EventMessageGet> {
  @override
  final Iterable<Type> types = const [EventMessageGet, _$EventMessageGet];

  @override
  final String wireName = r'EventMessageGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EventMessageGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    if (object.isRead != null) {
      yield r'is_read';
      yield serializers.serialize(
        object.isRead,
        specifiedType: const FullType(bool),
      );
    }
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(EventGet),
    );
    yield r'recipient';
    yield serializers.serialize(
      object.recipient,
      specifiedType: const FullType(UserGet),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EventMessageGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EventMessageGetBuilder result,
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
        case r'is_read':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isRead = valueDes;
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EventGet),
          ) as EventGet;
          result.event.replace(valueDes);
          break;
        case r'recipient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserGet),
          ) as UserGet;
          result.recipient.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EventMessageGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EventMessageGetBuilder();
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

