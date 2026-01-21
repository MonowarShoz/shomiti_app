import 'dart:convert';

SaveKistiReceiveBody saveKistiReceiveBodyFromJson(String str) => SaveKistiReceiveBody.fromJson(json.decode(str));

String saveKistiReceiveBodyToJson(SaveKistiReceiveBody data) => json.encode(data.toJson());

class SaveKistiReceiveBody {
  int? projectid;
  int? typeid;
  int? compId;
  int? memNo;
  int? paybleamount;
  int? recamount;
  String? remark;
  String? recdate;
  String? recmonth;
  int? recyear;
  String? transby;

  SaveKistiReceiveBody({
    this.projectid,
    this.typeid,
    this.compId,
    this.memNo,
    this.paybleamount,
    this.recamount,
    this.remark,
    this.recdate,
    this.recmonth,
    this.recyear,
    this.transby,
  });

  factory SaveKistiReceiveBody.fromJson(Map<String, dynamic> json) => SaveKistiReceiveBody(
    projectid: json["projectid"],
    typeid: json["typeid"],
    compId: json["compId"],
    memNo: json["memNo"],
    paybleamount: json["paybleamount"],
    recamount: json["recamount"],
    remark: json["remark"],
    recdate: json["recdate"],
    recmonth: json["recmonth"],
    recyear: json["recyear"],
    transby: json["transby"],
  );

  Map<String, dynamic> toJson() => {
    "projectid": projectid,
    "typeid": typeid,
    "compId": compId,
    "memNo": memNo,
    "paybleamount": paybleamount,
    "recamount": recamount,
    "remark": remark,
    "recdate": recdate,
    "recmonth": recmonth,
    "recyear": recyear,
    "transby": transby,
  };
}