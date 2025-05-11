import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCagegoryModel {
  final String brandId;
  final String categoryId;

  BrandCagegoryModel({required this.brandId, required this.categoryId});

  Map<String, dynamic> toJson() {
    return {'brandId': brandId, 'categoryId': categoryId};
  }

  factory BrandCagegoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BrandCagegoryModel(
      brandId: data['brandId'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}
