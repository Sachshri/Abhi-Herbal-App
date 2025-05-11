class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  toJson() {
    return {
      'Id': id,
      'SKU': sku,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: data.containsKey('Id') ? data['Id'] : '',
      attributeValues: data.containsKey('AttributeValues') ? Map<String, String>.from(data['AttributeValues']) : {},
      sku: data.containsKey('SKU') ? data['SKU'] : '',
      image: data.containsKey('Image') ? data['Image'] : '',
      description: data.containsKey('Description') ? data['Description'] : '',
      price: data.containsKey('Price') ? double.parse((data['Price']??0.0).toString()): 0.0,
      salePrice: data.containsKey('SalePrice') ? double.parse((data['SalePrice']??0.0).toString()): 0.0,
      stock: data['Stock'] ?? 0,
    );
  }

}
