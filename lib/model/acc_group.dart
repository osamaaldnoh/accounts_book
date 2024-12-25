import 'dart:convert';

class AccGroup {
  int? accGroupId;
  String? accGroupName;
  String? created_at;
  int? status;

  AccGroup({this.accGroupId, this.accGroupName, this.created_at, this.status});

  factory AccGroup.map(Map<String, dynamic> json) {
    return AccGroup(
      accGroupId: json['accGroupId'],
      accGroupName: json['accGroupName'],
      created_at: json['created_at'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'accGroupId': accGroupId,
      'accGroupName': accGroupName,
      'created_at': created_at,
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  factory AccGroup.fromJson(String source) => AccGroup.map(json.decode(source));
}
