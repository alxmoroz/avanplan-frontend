//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'message_channel_get.g.dart';

/// MessageChannelGet
///
/// Properties:
/// * [id] 
/// * [title] 
@BuiltValue()
abstract class MessageChannelGet implements Built<MessageChannelGet, MessageChannelGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'title')
  String get title;

  MessageChannelGet._();

  factory MessageChannelGet([void updates(MessageChannelGetBuilder b)]) = _$MessageChannelGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessageChannelGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessageChannelGet> get serializer => _$MessageChannelGetSerializer();
}

class _$MessageChannelGetSerializer implements PrimitiveSerializer<MessageChannelGet> {
  @override
  final Iterable<Type> types = const [MessageChannelGet, _$MessageChannelGet];

  @override
  final String wireName = r'MessageChannelGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessageChannelGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MessageChannelGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessageChannelGetBuilder result,
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MessageChannelGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessageChannelGetBuilder();
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

