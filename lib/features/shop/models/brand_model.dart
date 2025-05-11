import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  // Empty Helper function
  static BrandModel empty() {
    return BrandModel(id: "", image: '', name: '');
  }
  // Creating a function for Converting model to json structure

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Id": id,
      "IsFeatured": isFeatured,
      "ProductsCount": productsCount,
      "Image": image,
    };
  }
  // Creating a function TO convert Json to Category Model

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return BrandModel.empty();
    } else {
      return BrandModel(
        id: data['Id'] ?? '',
        name: data['Name'] ?? "",
        isFeatured: data["IsFeatured"] ?? false,
        image: data["Image"] ?? "",
        productsCount: int.parse(data['ProductsCount'].toString()),
      );
    }
  }
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data ==null) {
      return BrandModel.empty();
    } else {
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? "",
        isFeatured: data["IsFeatured"] ?? false,
        image: data["Image"] ?? "",
        productsCount: int.parse(data['ProductsCount'].toString()),
      );
    }
  }
}
