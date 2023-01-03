//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'event_message_upsert.g.dart';

/// EventMessageUpsert
///
/// Properties:
/// * [id] 
/// * [isRead] 
/// * [eventId] 
/// * [recipientId] 
@BuiltValue()
abstract class EventMessageUpsert implements Built<EventMessageUpsert, EventMessageUpsertBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'is_read')
  bool? get isRead;

  @BuiltValueField(wireName: r'event_id')
  int get eventId;

  @BuiltValueField(wireName: r'recipient_id')
  int get recipientId;

  EventMessageUpsert._();

  factory EventMessageUpsert([void updates(EventMessageUpsertBuilder b)]) = _$EventMessageUpsert;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EventMessageUpsertBuilder b) => b
      ..isRead = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<EventMessageUpsert> get serializer => _$EventMessageUpsertSerializer();
}

class _$EventMessageUpsertSerializer implements PrimitiveSerializer<EventMessageUpsert> {
  @override
  final Iterable<Type> types = const [EventMessageUpsert, _$EventMessageUpsert];

  @override
  final String wireName = r'EventMessageUpsert';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EventMessageUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.isRead != null) {
      yield r'is_read';
      yield serializers.serialize(
        object.isRead,
        specifiedType: const FullType(bool),
      );
    }
    yield r'event_id';
    yield serializers.serialize(
      object.eventId,
      specifiedType: const FullType(int),
    );
    yield r'recipient_id';
    yield serializers.serialize(
      object.recipientId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EventMessageUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EventMessageUpsertBuilder result,
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
        case r'event_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.eventId = valueDes;
          break;
        case r'recipient_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.recipientId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EventMessageUpsert deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EventMessageUpsertBuilder();
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

