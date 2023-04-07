//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_operation_get.g.dart';

/// AccountOperationGet
///
/// Properties:
/// * [id] 
/// * [createdOn] 
/// * [amount] 
/// * [basis] 
/// * [description] 
@BuiltValue()
abstract class AccountOperationGet implements Built<AccountOperationGet, AccountOperationGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'created_on')
  DateTime get createdOn;

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'basis')
  String get basis;

  @BuiltValueField(wireName: r'description')
  String? get description;

  AccountOperationGet._();

  factory AccountOperationGet([void updates(AccountOperationGetBuilder b)]) = _$AccountOperationGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountOperationGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountOperationGet> get serializer => _$AccountOperationGetSerializer();
}

class _$AccountOperationGetSerializer implements PrimitiveSerializer<AccountOperationGet> {
  @override
  final Iterable<Type> types = const [AccountOperationGet, _$AccountOperationGet];

  @override
  final String wireName = r'AccountOperationGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountOperationGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'created_on';
    yield serializers.serialize(
      object.createdOn,
      specifiedType: const FullType(DateTime),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'basis';
    yield serializers.serialize(
      object.basis,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountOperationGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountOperationGetBuilder result,
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
        case r'created_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdOn = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'basis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.basis = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountOperationGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountOperationGetBuilder();
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

