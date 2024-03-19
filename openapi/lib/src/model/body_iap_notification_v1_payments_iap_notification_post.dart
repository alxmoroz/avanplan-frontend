//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_iap_notification_v1_payments_iap_notification_post.g.dart';

/// BodyIapNotificationV1PaymentsIapNotificationPost
///
/// Properties:
/// * [amount] 
/// * [operationId] 
/// * [psystemCode] 
@BuiltValue()
abstract class BodyIapNotificationV1PaymentsIapNotificationPost implements Built<BodyIapNotificationV1PaymentsIapNotificationPost, BodyIapNotificationV1PaymentsIapNotificationPostBuilder> {
  @BuiltValueField(wireName: r'amount')
  int get amount;

  @BuiltValueField(wireName: r'operation_id')
  String get operationId;

  @BuiltValueField(wireName: r'psystem_code')
  String? get psystemCode;

  BodyIapNotificationV1PaymentsIapNotificationPost._();

  factory BodyIapNotificationV1PaymentsIapNotificationPost([void updates(BodyIapNotificationV1PaymentsIapNotificationPostBuilder b)]) = _$BodyIapNotificationV1PaymentsIapNotificationPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyIapNotificationV1PaymentsIapNotificationPostBuilder b) => b
      ..psystemCode = 'APPLE_IAP';

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyIapNotificationV1PaymentsIapNotificationPost> get serializer => _$BodyIapNotificationV1PaymentsIapNotificationPostSerializer();
}

class _$BodyIapNotificationV1PaymentsIapNotificationPostSerializer implements PrimitiveSerializer<BodyIapNotificationV1PaymentsIapNotificationPost> {
  @override
  final Iterable<Type> types = const [BodyIapNotificationV1PaymentsIapNotificationPost, _$BodyIapNotificationV1PaymentsIapNotificationPost];

  @override
  final String wireName = r'BodyIapNotificationV1PaymentsIapNotificationPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyIapNotificationV1PaymentsIapNotificationPost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(int),
    );
    yield r'operation_id';
    yield serializers.serialize(
      object.operationId,
      specifiedType: const FullType(String),
    );
    if (object.psystemCode != null) {
      yield r'psystem_code';
      yield serializers.serialize(
        object.psystemCode,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyIapNotificationV1PaymentsIapNotificationPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyIapNotificationV1PaymentsIapNotificationPostBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amount = valueDes;
          break;
        case r'operation_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.operationId = valueDes;
          break;
        case r'psystem_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.psystemCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyIapNotificationV1PaymentsIapNotificationPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyIapNotificationV1PaymentsIapNotificationPostBuilder();
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

