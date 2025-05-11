import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_flutter_app/features/personalization/models/address_model.dart';
import 'package:new_flutter_app/features/shop/models/cart_item_model.dart';
import 'package:new_flutter_app/utils/constants/enums.dart';
import 'package:new_flutter_app/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.totalAmount,
    required this.items,
    required this.orderDate,
    this.paymentMethod = 'Cash on Delivery',
    this.address,
    this.deliveryDate,
  });

Map<String, dynamic> toJson() {
  return {
    'id': id,
    'userId': userId,
    'status': status.toString(),
    'totalAmount': totalAmount.toDouble(), 
    'orderDate': orderDate,
    'paymentMethod': paymentMethod,
    'address': address?.toJson(),
    'deliveryDate': deliveryDate,
    'items': items.map((item) => item.toJson()).toList(),
  };
}


  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == data['status'],
      ),
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] ?? 'Cash on Delivery',
      address:
          data['address'] != null
              ? AddressModel.fromMap(data['address'] as Map<String,dynamic>)
              : null,
      deliveryDate:
          data['deliveryDate'] != null
              ? (data['deliveryDate'] as Timestamp).toDate()
              : null,
      items: data['items'] != null
    ? (data['items'] as List)
        .map((item) => CartItemModel.fromJson(item))
        .toList()
    : [],
    );
  }
  String get formattedOrderDate => HelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate =>
      deliveryDate != null
          ? HelperFunctions.getFormattedDate(deliveryDate!)
          : '';

  String get orderStatusText =>
      status == OrderStatus.delivered
          ? 'Delivered'
          : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';
}
