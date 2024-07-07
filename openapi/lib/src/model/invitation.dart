//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invitation.g.dart';

/// Invitation
///
/// Properties:
/// * [expiresOn] 
/// * [taskId] 
/// * [roleId] 
/// * [url] 
/// * [activationsCount] 
@BuiltValue()
abstract class Invitation implements Built<Invitation, InvitationBuilder> {
  @BuiltValueField(wireName: r'expires_on')
  DateTime get expiresOn;

  @BuiltValueField(wireName: r'task_id')
  int get taskId;

  @BuiltValueField(wireName: r'role_id')
  int get roleId;

  @BuiltValueField(wireName: r'url')
  String? get url;

  @BuiltValueField(wireName: r'activations_count')
  int? get activationsCount;

  Invitation._();

  factory Invitation([void updates(InvitationBuilder b)]) = _$Invitation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvitationBuilder b) => b
      ..activationsCount = 0;

  @BuiltValueSerializer(custom: true)
  static Serializer<Invitation> get serializer => _$InvitationSerializer();
}

class _$InvitationSerializer implements PrimitiveSerializer<Invitation> {
  @override
  final Iterable<Type> types = const [Invitation, _$Invitation];

  @override
  final String wireName = r'Invitation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Invitation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'expires_on';
    yield serializers.serialize(
      object.expiresOn,
      specifiedType: const FullType(DateTime),
    );
    yield r'task_id';
    yield serializers.serialize(
      object.taskId,
      specifiedType: const FullType(int),
    );
    yield r'role_id';
    yield serializers.serialize(
      object.roleId,
      specifiedType: const FullType(int),
    );
    if (object.url != null) {
      yield r'url';
      yield serializers.serialize(
        object.url,
        specifiedType: const FullType(String),
      );
    }
    if (object.activationsCount != null) {
      yield r'activations_count';
      yield serializers.serialize(
        object.activationsCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Invitation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InvitationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'expires_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresOn = valueDes;
          break;
        case r'task_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.taskId = valueDes;
          break;
        case r'role_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.roleId = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'activations_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.activationsCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Invitation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvitationBuilder();
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

