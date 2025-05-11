import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String parentId;
  String name;
  bool isFeatured;
  String image;
  String id;

  CategoryModel({
    this.parentId = "",
    required this.name,
    required this.isFeatured,
    required this.image,
    required this.id,
  });

  // Empty Helper function
  static CategoryModel empty() {
    return CategoryModel(name: "", isFeatured: false, image: '', id: "");
  }
  // Creating a function for Converting model to json structure

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "IsFeatured": isFeatured,
      "ParentId": parentId,
      "Image": image,
    };
  }
  // Creating a function TO convert Json to Category Model

  factory CategoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? "",
        isFeatured: data["IsFeatured"] ?? false,
        image: data["Image"] ?? "",
        parentId: data['ParentId'] ?? "",
      );
    } else {
      return CategoryModel.empty();
    }
  }


}
