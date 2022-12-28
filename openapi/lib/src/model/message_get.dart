//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/user_get.dart';
import 'package:openapi/src/model/event_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'message_get.g.dart';

/// MessageGet
///
/// Properties:
/// * [id] 
/// * [readDate] 
/// * [event] 
/// * [recipient] 
@BuiltValue()
abstract class MessageGet implements Built<MessageGet, MessageGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'read_date')
  DateTime? get readDate;

  @BuiltValueField(wireName: r'event')
  EventGet get event;

  @BuiltValueField(wireName: r'recipient')
  UserGet get recipient;

  MessageGet._();

  factory MessageGet([void updates(MessageGetBuilder b)]) = _$MessageGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessageGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessageGet> get serializer => _$MessageGetSerializer();
}

class _$MessageGetSerializer implements PrimitiveSerializer<MessageGet> {
  @override
  final Iterable<Type> types = const [MessageGet, _$MessageGet];

  @override
  final String wireName = r'MessageGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessageGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    if (object.readDate != null) {
      yield r'read_date';
      yield serializers.serialize(
        object.readDate,
        specifiedType: const FullType(DateTime),
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
    MessageGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessageGetBuilder result,
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
        case r'read_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.readDate = valueDes;
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
  MessageGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessageGetBuilder();
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

