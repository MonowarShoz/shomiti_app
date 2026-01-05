import 'dart:convert';

BalanceSegmentSaveModel balanceSegmentSaveModelFromJson(String str) => BalanceSegmentSaveModel.fromJson(json.decode(str));

String balanceSegmentSaveModelToJson(BalanceSegmentSaveModel data) => json.encode(data.toJson());

class BalanceSegmentSaveModel {
  int? id;
  int? compId;
  int? vendor;
  String? descri;
  int? amount;
  String? createDate;

  BalanceSegmentSaveModel({
    this.id,
    this.compId,
    this.vendor,
    this.descri,
    this.amount,
    this.createDate,
  });

  factory BalanceSegmentSaveModel.fromJson(Map<String, dynamic> json) => BalanceSegmentSaveModel(
    id: json["id"],
    compId: json["compId"],
    vendor: json["vendor"],
    descri: json["descri"],
    amount: json["amount"],
    createDate: json["createDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "compId": compId,
    "vendor": vendor,
    "descri": descri,
    "amount": amount,
    "createDate": createDate,
  };
}