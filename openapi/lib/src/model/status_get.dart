//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'status_get.g.dart';

/// StatusGet
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [closed] 
/// * [allProjects] 
@BuiltValue()
abstract class StatusGet implements Built<StatusGet, StatusGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'closed')
  bool get closed;

  @BuiltValueField(wireName: r'all_projects')
  bool? get allProjects;

  StatusGet._();

  factory StatusGet([void updates(StatusGetBuilder b)]) = _$StatusGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StatusGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StatusGet> get serializer => _$StatusGetSerializer();
}

class _$StatusGetSerializer implements PrimitiveSerializer<StatusGet> {
  @override
  final Iterable<Type> types = const [StatusGet, _$StatusGet];

  @override
  final String wireName = r'StatusGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StatusGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'closed';
    yield serializers.serialize(
      object.closed,
      specifiedType: const FullType(bool),
    );
    if (object.allProjects != null) {
      yield r'all_projects';
      yield serializers.serialize(
        object.allProjects,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StatusGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StatusGetBuilder result,
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
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'closed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.closed = valueDes;
          break;
        case r'all_projects':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.allProjects = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StatusGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StatusGetBuilder();
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

