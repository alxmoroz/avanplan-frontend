//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invoice_detail_get.g.dart';

/// InvoiceDetailGet
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [startDate] 
/// * [endDate] 
/// * [serviceAmount] 
/// * [invoiceId] 
/// * [promoActionCode] 
/// * [finalPrice] 
@BuiltValue()
abstract class InvoiceDetailGet implements Built<InvoiceDetailGet, InvoiceDetailGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'start_date')
  DateTime get startDate;

  @BuiltValueField(wireName: r'end_date')
  DateTime? get endDate;

  @BuiltValueField(wireName: r'service_amount')
  num get serviceAmount;

  @BuiltValueField(wireName: r'invoice_id')
  int get invoiceId;

  @BuiltValueField(wireName: r'promo_action_code')
  String? get promoActionCode;

  @BuiltValueField(wireName: r'final_price')
  num? get finalPrice;

  InvoiceDetailGet._();

  factory InvoiceDetailGet([void updates(InvoiceDetailGetBuilder b)]) = _$InvoiceDetailGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvoiceDetailGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InvoiceDetailGet> get serializer => _$InvoiceDetailGetSerializer();
}

class _$InvoiceDetailGetSerializer implements PrimitiveSerializer<InvoiceDetailGet> {
  @override
  final Iterable<Type> types = const [InvoiceDetailGet, _$InvoiceDetailGet];

  @override
  final String wireName = r'InvoiceDetailGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InvoiceDetailGet object, {
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
    yield r'start_date';
    yield serializers.serialize(
      object.startDate,
      specifiedType: const FullType(DateTime),
    );
    if (object.endDate != null) {
      yield r'end_date';
      yield serializers.serialize(
        object.endDate,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'service_amount';
    yield serializers.serialize(
      object.serviceAmount,
      specifiedType: const FullType(num),
    );
    yield r'invoice_id';
    yield serializers.serialize(
      object.invoiceId,
      specifiedType: const FullType(int),
    );
    if (object.promoActionCode != null) {
      yield r'promo_action_code';
      yield serializers.serialize(
        object.promoActionCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.finalPrice != null) {
      yield r'final_price';
      yield serializers.serialize(
        object.finalPrice,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InvoiceDetailGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InvoiceDetailGetBuilder result,
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
        case r'service_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.serviceAmount = valueDes;
          break;
        case r'invoice_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.invoiceId = valueDes;
          break;
        case r'promo_action_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.promoActionCode = valueDes;
          break;
        case r'final_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.finalPrice = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InvoiceDetailGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvoiceDetailGetBuilder();
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

