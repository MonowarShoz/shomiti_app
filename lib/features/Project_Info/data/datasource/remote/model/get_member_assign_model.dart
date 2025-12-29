import 'dart:convert';

List<MemberAssigninfoModel> memberAssigninfoModelFromJson(String str) => List<MemberAssigninfoModel>.from(json.decode(str).map((x) => MemberAssigninfoModel.fromJson(x)));

String memberAssigninfoModelToJson(List<MemberAssigninfoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberAssigninfoModel {
  int? id;
  int? memNo;
  int? projectid;
  String? projectname;
  int? amount;
  String? givenName;
  String? sureName;
  int? compId;
  String? assignDate;
  String? assignBy;

  MemberAssigninfoModel({
    this.id,
    this.memNo,
    this.projectid,
    this.projectname,
    this.amount,
    this.givenName,
    this.sureName,
    this.compId,
    this.assignDate,
    this.assignBy,
  });

  factory MemberAssigninfoModel.fromJson(Map<String, dynamic> json) => MemberAssigninfoModel(
    id: json["id"],
    memNo: json["memNo"],
    projectid: json["projectid"],
    projectname: json["projectname"],
    amount: json["amount"],
    givenName: json["givenName"],
    sureName: json["sureName"],
    compId: json["compId"],
    assignDate: json["assignDate"],
    assignBy: json["assignBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "memNo": memNo,
    "projectid": projectid,
    "projectname": projectname,
    "amount": amount,
    "givenName": givenName,
    "sureName": sureName,
    "compId": compId,
    "assignDate": assignDate,
    "assignBy": assignBy,
  };
}