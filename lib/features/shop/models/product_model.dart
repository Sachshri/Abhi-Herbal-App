import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_flutter_app/features/shop/models/brand_model.dart';
import 'package:new_flutter_app/features/shop/models/product_attribute_model.dart';
import 'package:new_flutter_app/features/shop/models/product_variation_model.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.title,
    required this.thumbnail,
    required this.productType,
    this.salePrice,
    this.images,
    this.date,
    this.sku,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.productAttributes,
    this.productVariations,
  });

  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double? salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  factory ProductModel.empty() {
    return ProductModel(
      id: '',
      stock: 0,
      price: 0.0,
      title: '',
      thumbnail: '',
      productType: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand?.toJson(),
      'Description': description,
      'ProductType': productType,
      'ProductAttributes':
          productAttributes != null
              ? productAttributes!.map((attr) => attr.toJson()).toList()
              : [],
      'ProductVariations':
          productVariations != null
              ? productVariations!
                  .map((variation) => variation.toJson())
                  .toList()
              : [],
    };
  }

  factory ProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data == null) return ProductModel.empty();

    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId']?.toString() ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',

      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,

      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes:
          (data['ProductAttributes'] is List<dynamic>)
              ? (data['ProductAttributes'] as List<dynamic>)
                  .map((e) => ProductAttributeModel.fromJson(e))
                  .toList()
              : [],

      productVariations:
          (data['ProductVariations'] is List<dynamic>)
              ? (data['ProductVariations'] as List<dynamic>)
                  .map((e) => ProductVariationModel.fromJson(e))
                  .toList()
              : [],
    );
  }

  factory ProductModel.fromQuerySnapshot(
    QueryDocumentSnapshot<Object?> document,
  ) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId']?.toString() ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',

      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,

      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes:
          (data['ProductAttributes'] is List<dynamic>)
              ? (data['ProductAttributes'] as List<dynamic>)
                  .map((e) => ProductAttributeModel.fromJson(e))
                  .toList()
              : [],

      productVariations:
          (data['ProductVariations'] is List<dynamic>)
              ? (data['ProductVariations'] as List<dynamic>)
                  .map((e) => ProductVariationModel.fromJson(e))
                  .toList()
              : [],
    );
  }

}
