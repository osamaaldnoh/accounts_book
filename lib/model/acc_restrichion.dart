import 'dart:convert';

class AccRestrichion {
  int? accRestrichionId;
  String? accRestrichionDetails;
  int? customerId;
  int? currencyId;
  String? registerdon;
  int? credit, debit;
  int? accGroupId;

  AccRestrichion({
    this.accRestrichionId,
    this.accRestrichionDetails,
    this.customerId,
    this.currencyId,
    this.registerdon,
    this.credit,
    this.debit,
    this.accGroupId,
  });

  factory AccRestrichion.map(Map<String, dynamic> json) {
    return AccRestrichion(
      accRestrichionId: json['accRestrichionId'],
      accRestrichionDetails: json['accRestrichionDetails'],
      customerId: json['customerId'],
      currencyId: json['currencyId'],
      registerdon: json['registerdon'],
      credit: json['credit'],
      debit: json['debit'],
      accGroupId: json['accGroupId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accRestrichionId': accRestrichionId,
      'accRestrichionDetails': accRestrichionDetails,
      'customerId': customerId,
      'currencyId': currencyId,
      'registerdon': registerdon,
      'credit': credit,
      'debit': debit,
      'accGroupId': accGroupId,
    };
  }

  String toJson() => json.encode(toMap());

  factory AccRestrichion.fromJson(String source) =>
      AccRestrichion.map(json.decode(source));
}
