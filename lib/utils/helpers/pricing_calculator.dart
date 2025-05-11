class PriceCalculator {
  PriceCalculator._();
  //calculate Total Price
  static double calculateTotalPrice(
    double productPrice,
    String location,
    int items,
  ) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = getShippingCost(location, items);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  //Calculating Shipping Cost (get shipping cost)
  static String calculateShippingCost(
    double productPrice,
    String location,
    int items,
  ) {
    if (items == 0) return 0.toString();
    double shippingCost = getShippingCost(location, items);
    return shippingCost.toStringAsFixed(2);
  }

  // get Tax
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  //Location based Tax Rate
  static double getTaxRateForLocation(String location) {
    return 0.05;
  }

  // Location based Shipping Cost
  static double getShippingCost(String location, int items) {
    if (items == 0) return 0;
    return 10;
  }

  // Total cart Price value
  // Todo
  //   static double calculateCartTotal(CartModel cart) {
  //     return cart.items.map((e) => e.price).fold(0,
  //         (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
  //   }
}
