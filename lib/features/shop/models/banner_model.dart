import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageUrl;
  final String targetScreen;
  final bool active;
  
  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  // Empty Helper function
  static BannerModel empty() {
    return BannerModel(targetScreen: "", active: false, imageUrl: '');
  }
  // Creating a function for Converting model to json structure

  Map<String, dynamic> toJson() {
    return {
      "ImageUrl": imageUrl,
      "TargetScreen": targetScreen,
      "Active": active,
    };
  }
  // Creating a function TO convert Json to Category Model

  factory BannerModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return BannerModel(
        imageUrl: data['ImageUrl'] ?? "",
        active: data['Active'] ?? false,
        targetScreen: data["TargetScreen"] ?? "",
      );
    } else {
      return BannerModel.empty();
    }
  }


}
