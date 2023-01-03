//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ws_settings_get.g.dart';

/// WSSettingsGet
///
/// Properties:
/// * [id] 
/// * [workspaceId] 
/// * [estimateUnit] 
@BuiltValue()
abstract class WSSettingsGet implements Built<WSSettingsGet, WSSettingsGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'workspace_id')
  int get workspaceId;

  @BuiltValueField(wireName: r'estimate_unit')
  String? get estimateUnit;

  WSSettingsGet._();

  factory WSSettingsGet([void updates(WSSettingsGetBuilder b)]) = _$WSSettingsGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WSSettingsGetBuilder b) => b
      ..estimateUnit = 'sp';

  @BuiltValueSerializer(custom: true)
  static Serializer<WSSettingsGet> get serializer => _$WSSettingsGetSerializer();
}

class _$WSSettingsGetSerializer implements PrimitiveSerializer<WSSettingsGet> {
  @override
  final Iterable<Type> types = const [WSSettingsGet, _$WSSettingsGet];

  @override
  final String wireName = r'WSSettingsGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WSSettingsGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'workspace_id';
    yield serializers.serialize(
      object.workspaceId,
      specifiedType: const FullType(int),
    );
    if (object.estimateUnit != null) {
      yield r'estimate_unit';
      yield serializers.serialize(
        object.estimateUnit,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WSSettingsGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WSSettingsGetBuilder result,
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
        case r'workspace_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workspaceId = valueDes;
          break;
        case r'estimate_unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimateUnit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WSSettingsGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WSSettingsGetBuilder();
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

