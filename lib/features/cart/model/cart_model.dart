import 'package:bright_minds/core/api/end_point.dart';

class CartModel {
  final int statusCode;
  final String? message;
  final CartData data;

  CartModel({
    required this.statusCode,
    this.message,
    required this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      statusCode: json[ApiKey.statusCode] as int,
      message: json[ApiKey.message] as String?,
      data: CartData.fromJson(json[ApiKey.data] as Map<String, dynamic>),
    );
  }
}

class CartData {
  final int id;
  final double totalPrice;
  final List<CartItem> items;

  CartData({
    required this.id,
    required this.totalPrice,
    required this.items,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    // معالجة مفتاح "totalPirce" إن كان موجودًا
    final rawTotal = json[ApiKey.totalPrice] ?? json['totalPirce'] ?? 0;
    final total = (rawTotal is num ? rawTotal : 0).toDouble();

    // تحويل الـ items إلى قائمة فارغة إذا كانت null
    final itemsJson = json[ApiKey.items] as List<dynamic>?;
    final itemList = itemsJson != null
        ? itemsJson
            .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList()
        : <CartItem>[];

    return CartData(
      id: json[ApiKey.id] as int,
      totalPrice: total,
      items: itemList,
    );
  }
}

class CartItem {
  final int id;
  final String courseId;
  final String courseName;
  final double price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.courseId,
    required this.courseName,
    required this.price,
    required this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json[ApiKey.id] as int,
      courseId: json[ApiKey.courseId].toString(),
      courseName: json[ApiKey.courseName] as String,
      price: (json[ApiKey.price] as num).toDouble(),
      imageUrl: json[ApiKey.imageUrl] as String,
    );
  }
}
