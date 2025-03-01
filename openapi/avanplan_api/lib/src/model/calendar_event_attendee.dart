//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'calendar_event_attendee.g.dart';

/// CalendarEventAttendee
///
/// Properties:
/// * [email] 
/// * [fullName] 
/// * [nickName] 
/// * [sourceCode] 
@BuiltValue()
abstract class CalendarEventAttendee implements Built<CalendarEventAttendee, CalendarEventAttendeeBuilder> {
  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'full_name')
  String? get fullName;

  @BuiltValueField(wireName: r'nick_name')
  String? get nickName;

  @BuiltValueField(wireName: r'source_code')
  String? get sourceCode;

  CalendarEventAttendee._();

  factory CalendarEventAttendee([void updates(CalendarEventAttendeeBuilder b)]) = _$CalendarEventAttendee;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CalendarEventAttendeeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CalendarEventAttendee> get serializer => _$CalendarEventAttendeeSerializer();
}

class _$CalendarEventAttendeeSerializer implements PrimitiveSerializer<CalendarEventAttendee> {
  @override
  final Iterable<Type> types = const [CalendarEventAttendee, _$CalendarEventAttendee];

  @override
  final String wireName = r'CalendarEventAttendee';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CalendarEventAttendee object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    if (object.fullName != null) {
      yield r'full_name';
      yield serializers.serialize(
        object.fullName,
        specifiedType: const FullType(String),
      );
    }
    if (object.nickName != null) {
      yield r'nick_name';
      yield serializers.serialize(
        object.nickName,
        specifiedType: const FullType(String),
      );
    }
    if (object.sourceCode != null) {
      yield r'source_code';
      yield serializers.serialize(
        object.sourceCode,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CalendarEventAttendee object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CalendarEventAttendeeBuilder result,
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
        case r'full_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fullName = valueDes;
          break;
        case r'nick_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nickName = valueDes;
          break;
        case r'source_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CalendarEventAttendee deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CalendarEventAttendeeBuilder();
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

