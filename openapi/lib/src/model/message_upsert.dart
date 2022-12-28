//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'message_upsert.g.dart';

/// MessageUpsert
///
/// Properties:
/// * [id] 
/// * [scheduledDate] 
/// * [sentDate] 
/// * [readDate] 
/// * [eventId] 
/// * [channelId] 
/// * [recipientId] 
@BuiltValue()
abstract class MessageUpsert implements Built<MessageUpsert, MessageUpsertBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'scheduled_date')
  DateTime? get scheduledDate;

  @BuiltValueField(wireName: r'sent_date')
  DateTime? get sentDate;

  @BuiltValueField(wireName: r'read_date')
  DateTime? get readDate;

  @BuiltValueField(wireName: r'event_id')
  int get eventId;

  @BuiltValueField(wireName: r'channel_id')
  int get channelId;

  @BuiltValueField(wireName: r'recipient_id')
  int? get recipientId;

  MessageUpsert._();

  factory MessageUpsert([void updates(MessageUpsertBuilder b)]) = _$MessageUpsert;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessageUpsertBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessageUpsert> get serializer => _$MessageUpsertSerializer();
}

class _$MessageUpsertSerializer implements PrimitiveSerializer<MessageUpsert> {
  @override
  final Iterable<Type> types = const [MessageUpsert, _$MessageUpsert];

  @override
  final String wireName = r'MessageUpsert';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessageUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.scheduledDate != null) {
      yield r'scheduled_date';
      yield serializers.serialize(
        object.scheduledDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.sentDate != null) {
      yield r'sent_date';
      yield serializers.serialize(
        object.sentDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.readDate != null) {
      yield r'read_date';
      yield serializers.serialize(
        object.readDate,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'event_id';
    yield serializers.serialize(
      object.eventId,
      specifiedType: const FullType(int),
    );
    yield r'channel_id';
    yield serializers.serialize(
      object.channelId,
      specifiedType: const FullType(int),
    );
    if (object.recipientId != null) {
      yield r'recipient_id';
      yield serializers.serialize(
        object.recipientId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MessageUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessageUpsertBuilder result,
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
        case r'scheduled_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.scheduledDate = valueDes;
          break;
        case r'sent_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.sentDate = valueDes;
          break;
        case r'read_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.readDate = valueDes;
          break;
        case r'event_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.eventId = valueDes;
          break;
        case r'channel_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.channelId = valueDes;
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
  MessageUpsert deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessageUpsertBuilder();
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

