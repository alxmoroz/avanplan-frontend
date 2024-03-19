//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/calendar_event_attendee.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'calendar_event.g.dart';

/// CalendarEvent
///
/// Properties:
/// * [title] 
/// * [description] 
/// * [calendarId] 
/// * [startDate] 
/// * [endDate] 
/// * [allDay] 
/// * [location] 
/// * [attendees] 
/// * [sourceCode] 
@BuiltValue()
abstract class CalendarEvent implements Built<CalendarEvent, CalendarEventBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'calendar_id')
  int get calendarId;

  @BuiltValueField(wireName: r'start_date')
  DateTime get startDate;

  @BuiltValueField(wireName: r'end_date')
  DateTime get endDate;

  @BuiltValueField(wireName: r'all_day')
  bool? get allDay;

  @BuiltValueField(wireName: r'location')
  String? get location;

  @BuiltValueField(wireName: r'attendees')
  BuiltList<CalendarEventAttendee>? get attendees;

  @BuiltValueField(wireName: r'source_code')
  String? get sourceCode;

  CalendarEvent._();

  factory CalendarEvent([void updates(CalendarEventBuilder b)]) = _$CalendarEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CalendarEventBuilder b) => b
      ..allDay = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<CalendarEvent> get serializer => _$CalendarEventSerializer();
}

class _$CalendarEventSerializer implements PrimitiveSerializer<CalendarEvent> {
  @override
  final Iterable<Type> types = const [CalendarEvent, _$CalendarEvent];

  @override
  final String wireName = r'CalendarEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CalendarEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    yield r'calendar_id';
    yield serializers.serialize(
      object.calendarId,
      specifiedType: const FullType(int),
    );
    yield r'start_date';
    yield serializers.serialize(
      object.startDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'end_date';
    yield serializers.serialize(
      object.endDate,
      specifiedType: const FullType(DateTime),
    );
    if (object.allDay != null) {
      yield r'all_day';
      yield serializers.serialize(
        object.allDay,
        specifiedType: const FullType(bool),
      );
    }
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType(String),
      );
    }
    if (object.attendees != null) {
      yield r'attendees';
      yield serializers.serialize(
        object.attendees,
        specifiedType: const FullType(BuiltList, [FullType(CalendarEventAttendee)]),
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
    CalendarEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CalendarEventBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'calendar_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.calendarId = valueDes;
          break;
        case r'start_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startDate = valueDes;
          break;
        case r'end_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.endDate = valueDes;
          break;
        case r'all_day':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.allDay = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.location = valueDes;
          break;
        case r'attendees':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(CalendarEventAttendee)]),
          ) as BuiltList<CalendarEventAttendee>;
          result.attendees.replace(valueDes);
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
  CalendarEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CalendarEventBuilder();
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

