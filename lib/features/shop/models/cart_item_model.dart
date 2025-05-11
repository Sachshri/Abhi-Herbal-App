class CartItemModel {
  String productId;
  String title;
  String? image;
  int quantity;
  double price;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;
  CartItemModel({
    required this.productId,
    this.title='',
    this.image,
    required this.quantity,
    this.price=0.0,
    this.variationId='',
    this.brandName,
    this.selectedVariation,
  });
  static CartItemModel empty() {
    return CartItemModel(
      productId: '',
      quantity: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'image': image,
      'quantity': quantity,
      'price': price,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] as String,
      title: json['title'] as String? ?? '',
      image: json['image'] as String?,
      quantity: json['quantity'] as int,
      price: json['price'] as double? ?? 0.0,
      variationId: json['variationId'] as String? ?? '',
      brandName: json['brandName'] as String?,
      selectedVariation: (json['selectedVariation'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value as String)),
    );
  }
  
}
