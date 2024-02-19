// Copyright (c) 2024. Alexandr Moroz

//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_release_notes.g.dart';

/// BodyReleaseNotes
///
/// Properties:
/// * [oldVersion]
@BuiltValue()
abstract class BodyReleaseNotes implements Built<BodyReleaseNotes, BodyReleaseNotesBuilder> {
  @BuiltValueField(wireName: r'old_version')
  String get oldVersion;

  BodyReleaseNotes._();

  factory BodyReleaseNotes([void updates(BodyReleaseNotesBuilder b)]) = _$BodyReleaseNotes;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyReleaseNotesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyReleaseNotes> get serializer => _$BodyReleaseNotesSerializer();
}

class _$BodyReleaseNotesSerializer implements PrimitiveSerializer<BodyReleaseNotes> {
  @override
  final Iterable<Type> types = const [BodyReleaseNotes, _$BodyReleaseNotes];

  @override
  final String wireName = r'BodyReleaseNotes';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyReleaseNotes object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'old_version';
    yield serializers.serialize(
      object.oldVersion,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyReleaseNotes object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyReleaseNotesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'old_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.oldVersion = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyReleaseNotes deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyReleaseNotesBuilder();
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
