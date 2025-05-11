class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  toJson() {
    return {"Name": name, 'Values': values};
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
      name: document.containsKey('Name') ? document['Name']:'',
      values:
          (document['Values'] is List)
              ? List<String>.from(document['Values'])
              : [],
    );
  }
}
