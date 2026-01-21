import 'dart:convert';

List<BalanceAddHistoryModel> balanceAddHistoryModelFromJson(String str) => List<BalanceAddHistoryModel>.from(json.decode(str).map((x) => BalanceAddHistoryModel.fromJson(x)));

String balanceAddHistoryModelToJson(List<BalanceAddHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BalanceAddHistoryModel {
  int? id;
  int? compId;
  int? vendor;
  String? vType;
  String? descri;
  int? amount;
  String? adate;

  BalanceAddHistoryModel({
    this.id,
    this.compId,
    this.vendor,
    this.vType,
    this.descri,
    this.amount,
    this.adate,
  });

  factory BalanceAddHistoryModel.fromJson(Map<String, dynamic> json) => BalanceAddHistoryModel(
    id: json["id"],
    compId: json["compId"],
    vendor: json["vendor"],
    vType: json["vType"],
    descri: json["descri"],
    amount: json["amount"],
    adate: json["adate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "compId": compId,
    "vendor": vendor,
    "vType": vType,
    "descri": descri,
    "amount": amount,
    "adate": adate,
  };
}