import 'dart:convert';

SaveSubscriptionTypeBody saveSubscriptionTypeBodyFromJson(String str) => SaveSubscriptionTypeBody.fromJson(json.decode(str));

String saveSubscriptionTypeBodyToJson(SaveSubscriptionTypeBody data) => json.encode(data.toJson());

class SaveSubscriptionTypeBody {
  int? id;
  String? typeName;
  int? crid;
  int? amount;
  String? createdate;
  String? updatedate;
  int? compId;
  int? projectId;

  SaveSubscriptionTypeBody({
    this.id,
    this.typeName,
    this.crid,
    this.amount,
    this.createdate,
    this.updatedate,
    this.compId,
    this.projectId,
  });

  factory SaveSubscriptionTypeBody.fromJson(Map<String, dynamic> json) => SaveSubscriptionTypeBody(
    id: json["id"],
    typeName: json["typeName"],
    crid: json["crid"],
    amount: json["amount"],
    createdate: json["createdate"],
    updatedate: json["updatedate"],
    compId: json["compId"],
    projectId: json["projectId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "typeName": typeName,
    "crid": crid,
    "amount": amount,
    "createdate": createdate,
    "updatedate": updatedate,
    "compId": compId,
    "projectId": projectId,
  };
}