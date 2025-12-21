import 'dart:convert';

KistiSaveModel kistiSaveModelFromJson(String str) => KistiSaveModel.fromJson(json.decode(str));

String kistiSaveModelToJson(KistiSaveModel data) => json.encode(data.toJson());

class KistiSaveModel {
  int? id;
  String? typeName;
  int? crid;
  int? amount;
  String? createdate;
  String? updatedate;
  int? compId;
  int? projectid;

  KistiSaveModel({
    this.id,
    this.typeName,
    this.crid,
    this.amount,
    this.createdate,
    this.updatedate,
    this.compId,
    this.projectid,
  });

  factory KistiSaveModel.fromJson(Map<String, dynamic> json) => KistiSaveModel(
    id: json["id"],
    typeName: json["typeName"],
    crid: json["crid"],
    amount: json["amount"],
    createdate: json["createdate"],
    updatedate: json["updatedate"],
    compId: json["compId"],
    projectid: json["projectid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "typeName": typeName,
    "crid": crid,
    "amount": amount,
    "createdate": createdate,
    "updatedate": updatedate,
    "compId": compId,
    "projectid": projectid,
  };
}