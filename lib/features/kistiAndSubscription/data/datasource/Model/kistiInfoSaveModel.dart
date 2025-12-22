import 'dart:convert';



class KistiSaveModel {
  final int? id;
  final String? typeName;
  final int? crid;
  final int? amount;
  final String? createdate;
  final String? updatedate;
  final int? compId;
  final int? projectid;

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