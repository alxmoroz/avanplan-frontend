//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/invoice_detail_get.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invoice_get.g.dart';

/// InvoiceGet
///
/// Properties:
/// * [id] 
/// * [billedOn] 
/// * [details] 
@BuiltValue()
abstract class InvoiceGet implements Built<InvoiceGet, InvoiceGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'billed_on')
  DateTime? get billedOn;

  @BuiltValueField(wireName: r'details')
  BuiltList<InvoiceDetailGet> get details;

  InvoiceGet._();

  factory InvoiceGet([void updates(InvoiceGetBuilder b)]) = _$InvoiceGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvoiceGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InvoiceGet> get serializer => _$InvoiceGetSerializer();
}

class _$InvoiceGetSerializer implements PrimitiveSerializer<InvoiceGet> {
  @override
  final Iterable<Type> types = const [InvoiceGet, _$InvoiceGet];

  @override
  final String wireName = r'InvoiceGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InvoiceGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    if (object.billedOn != null) {
      yield r'billed_on';
      yield serializers.serialize(
        object.billedOn,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'details';
    yield serializers.serialize(
      object.details,
      specifiedType: const FullType(BuiltList, [FullType(InvoiceDetailGet)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InvoiceGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InvoiceGetBuilder result,
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
        case r'billed_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.billedOn = valueDes;
          break;
        case r'details':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(InvoiceDetailGet)]),
          ) as BuiltList<InvoiceDetailGet>;
          result.details.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InvoiceGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvoiceGetBuilder();
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

