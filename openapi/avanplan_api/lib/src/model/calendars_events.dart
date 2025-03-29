//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:avanplan_api/src/model/calendar_event_get.dart';
import 'package:avanplan_api/src/model/calendar_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'calendars_events.g.dart';

/// CalendarsEvents
///
/// Properties:
/// * [calendars]
/// * [events]
@BuiltValue()
abstract class CalendarsEvents implements Built<CalendarsEvents, CalendarsEventsBuilder> {
  @BuiltValueField(wireName: r'calendars')
  BuiltList<CalendarGet> get calendars;

  @BuiltValueField(wireName: r'events')
  BuiltList<CalendarEventGet> get events;

  CalendarsEvents._();

  factory CalendarsEvents([void updates(CalendarsEventsBuilder b)]) = _$CalendarsEvents;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CalendarsEventsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CalendarsEvents> get serializer => _$CalendarsEventsSerializer();
}

class _$CalendarsEventsSerializer implements PrimitiveSerializer<CalendarsEvents> {
  @override
  final Iterable<Type> types = const [CalendarsEvents, _$CalendarsEvents];

  @override
  final String wireName = r'CalendarsEvents';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CalendarsEvents object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'calendars';
    yield serializers.serialize(
      object.calendars,
      specifiedType: const FullType(BuiltList, [FullType(CalendarGet)]),
    );
    yield r'events';
    yield serializers.serialize(
      object.events,
      specifiedType: const FullType(BuiltList, [FullType(CalendarEventGet)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CalendarsEvents object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CalendarsEventsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'calendars':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(CalendarGet)]),
          ) as BuiltList<CalendarGet>;
          result.calendars.replace(valueDes);
          break;
        case r'events':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(CalendarEventGet)]),
          ) as BuiltList<CalendarEventGet>;
          result.events.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CalendarsEvents deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CalendarsEventsBuilder();
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
