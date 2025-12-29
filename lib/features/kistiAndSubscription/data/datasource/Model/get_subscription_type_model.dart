import 'dart:convert';

List<GetSubscriptionTypeModel> getSubscriptionTypeModelFromJson(String str) => List<GetSubscriptionTypeModel>.from(json.decode(str).map((x) => GetSubscriptionTypeModel.fromJson(x)));

String getSubscriptionTypeModelToJson(List<GetSubscriptionTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSubscriptionTypeModel {
  int? id;
  String? typeName;
  int? crid;
  String? crname;
  int? amount;
  String? createdate;
  String? updatedate;
  int? projectId;
  String? projectName;

  GetSubscriptionTypeModel({
    this.id,
    this.typeName,
    this.crid,
    this.crname,
    this.amount,
    this.createdate,
    this.updatedate,
    this.projectId,
    this.projectName,
  });

  factory GetSubscriptionTypeModel.fromJson(Map<String, dynamic> json) => GetSubscriptionTypeModel(
    id: json["id"],
    typeName: json["typeName"],
    crid: json["crid"],
    crname: json["crname"],
    amount: json["amount"],
    createdate: json["createdate"],
    updatedate: json["updatedate"],
    projectId: json["projectId"],
    projectName: json["projectName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "typeName": typeName,
    "crid": crid,
    "crname": crname,
    "amount": amount,
    "createdate": createdate,
    "updatedate": updatedate,
    "projectId": projectId,
    "projectName": projectName,
  };
}