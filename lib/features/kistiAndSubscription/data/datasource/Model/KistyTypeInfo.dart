
import 'dart:convert';

List<KistyTypeInfo> kistyTypeInfoFromJson(String str) => List<KistyTypeInfo>.from(json.decode(str).map((x) => KistyTypeInfo.fromJson(x)));

String kistyTypeInfoToJson(List<KistyTypeInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KistyTypeInfo {
  int? id;
  String? typeName;
  int? crid;
  String? crname;
  int? amount;
  String? createdate;
  String? updatedate;
  int? projectid;
  String? projectname;

  KistyTypeInfo({
    this.id,
    this.typeName,
    this.crid,
    this.crname,
    this.amount,
    this.createdate,
    this.updatedate,
    this.projectid,
    this.projectname,
  });

  factory KistyTypeInfo.fromJson(Map<String, dynamic> json) => KistyTypeInfo(
    id: json["id"],
    typeName: json["typeName"],
    crid: json["crid"],
    crname: json["crname"],
    amount: json["amount"],
    createdate: json["createdate"],
    updatedate: json["updatedate"],
    projectid: json["projectid"],
    projectname: json["projectname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "typeName": typeName,
    "crid": crid,
    "crname": crname,
    "amount": amount,
    "createdate": createdate,
    "updatedate": updatedate,
    "projectid": projectid,
    "projectname": projectname,
  };
}
