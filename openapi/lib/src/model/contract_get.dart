//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/invoice_get.dart';
import 'package:openapi/src/model/tariff_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contract_get.g.dart';

/// ContractGet
///
/// Properties:
/// * [id] 
/// * [createdOn] 
/// * [expiresOn] 
/// * [terminated] 
/// * [tariffId] 
/// * [tariff] 
/// * [invoice] 
@BuiltValue()
abstract class ContractGet implements Built<ContractGet, ContractGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'created_on')
  DateTime get createdOn;

  @BuiltValueField(wireName: r'expires_on')
  DateTime? get expiresOn;

  @BuiltValueField(wireName: r'terminated')
  bool? get terminated;

  @BuiltValueField(wireName: r'tariff_id')
  int get tariffId;

  @BuiltValueField(wireName: r'tariff')
  TariffGet? get tariff;

  @BuiltValueField(wireName: r'invoice')
  InvoiceGet? get invoice;

  ContractGet._();

  factory ContractGet([void updates(ContractGetBuilder b)]) = _$ContractGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContractGetBuilder b) => b
      ..terminated = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContractGet> get serializer => _$ContractGetSerializer();
}

class _$ContractGetSerializer implements PrimitiveSerializer<ContractGet> {
  @override
  final Iterable<Type> types = const [ContractGet, _$ContractGet];

  @override
  final String wireName = r'ContractGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContractGet object, {
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
    if (object.expiresOn != null) {
      yield r'expires_on';
      yield serializers.serialize(
        object.expiresOn,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.terminated != null) {
      yield r'terminated';
      yield serializers.serialize(
        object.terminated,
        specifiedType: const FullType(bool),
      );
    }
    yield r'tariff_id';
    yield serializers.serialize(
      object.tariffId,
      specifiedType: const FullType(int),
    );
    if (object.tariff != null) {
      yield r'tariff';
      yield serializers.serialize(
        object.tariff,
        specifiedType: const FullType(TariffGet),
      );
    }
    if (object.invoice != null) {
      yield r'invoice';
      yield serializers.serialize(
        object.invoice,
        specifiedType: const FullType(InvoiceGet),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ContractGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ContractGetBuilder result,
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
        case r'expires_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresOn = valueDes;
          break;
        case r'terminated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.terminated = valueDes;
          break;
        case r'tariff_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.tariffId = valueDes;
          break;
        case r'tariff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TariffGet),
          ) as TariffGet;
          result.tariff.replace(valueDes);
          break;
        case r'invoice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(InvoiceGet),
          ) as InvoiceGet;
          result.invoice.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContractGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContractGetBuilder();
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

