class Sale {
  final String sid;
  final String userId;
  final String productId;
  final String productName;
  final int qty;
  final double price;
  final double total;
  final DateTime createdAt;
   final String? imageUrl;
  Sale({
    required this.sid,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.qty,
    required this.price,
    required this.total,
    required this.createdAt, 
    required this.imageUrl,
    
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      sid: json['sid'],
      userId: json['user_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      qty: json['qty'],
      price: (json['price'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      createdAt: DateTime.parse(json['create_at']),
      imageUrl: json['imageurl'],
    );
  }
}