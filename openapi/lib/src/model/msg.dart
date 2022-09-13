//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'msg.g.dart';

/// Msg
///
/// Properties:
/// * [msg] 
@BuiltValue()
abstract class Msg implements Built<Msg, MsgBuilder> {
  @BuiltValueField(wireName: r'msg')
  String get msg;

  Msg._();

  factory Msg([void updates(MsgBuilder b)]) = _$Msg;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MsgBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Msg> get serializer => _$MsgSerializer();
}

class _$MsgSerializer implements PrimitiveSerializer<Msg> {
  @override
  final Iterable<Type> types = const [Msg, _$Msg];

  @override
  final String wireName = r'Msg';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Msg object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'msg';
    yield serializers.serialize(
      object.msg,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Msg object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MsgBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'msg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.msg = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Msg deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MsgBuilder();
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

