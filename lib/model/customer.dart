import 'dart:convert';

class Customer {
  int? customerId;
  String? customerName;
  String? customerPhone;
  String? created_at;
  bool? status;

  Customer({
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.created_at,
    this.status,
  });

  factory Customer.map(Map<String, dynamic> json) {
    return Customer(
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      created_at: json['created_at'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'created_at': created_at,
      'status': status
    };
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.map(json.decode(source));
}
