import 'dart:convert';

List<TotalBalanceModel> totalBalanceModelFromJson(String str) => List<TotalBalanceModel>.from(json.decode(str).map((x) => TotalBalanceModel.fromJson(x)));

String totalBalanceModelToJson(List<TotalBalanceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalBalanceModel {
  int? id;
  int? compId;
  int? amount;
  DateTime? updateDate;

  TotalBalanceModel({
    this.id,
    this.compId,
    this.amount,
    this.updateDate,
  });

  factory TotalBalanceModel.fromJson(Map<String, dynamic> json) => TotalBalanceModel(
    id: json["id"],
    compId: json["compId"],
    amount: json["amount"],
    updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "compId": compId,
    "amount": amount,
    "updateDate": updateDate?.toIso8601String(),
  };
}