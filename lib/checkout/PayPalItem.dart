class PayPalItem {
  String name;
  String quantity;
  String price;
  String currency;

  PayPalItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.currency,
  });

  Map<String, String> toJson() {
    return {
      "name": name,
      "quantity": quantity.toString(),
      "price": price,
      "currency": currency,
    };
  }
}
