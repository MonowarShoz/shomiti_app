import 'dart:convert';

SaveWithDrawModel saveWithDrawModelFromJson(String str) => SaveWithDrawModel.fromJson(json.decode(str));

String saveWithDrawModelToJson(SaveWithDrawModel data) => json.encode(data.toJson());

class SaveWithDrawModel {
  int? id;
  int? compId;
  int? memNo;
  int? fProject;
  int? amount;
  String? remarks;
  String? wDate;
  String? wMonth;
  int? wYear;
  String? wBy;

  SaveWithDrawModel({
    this.id,
    this.compId,
    this.memNo,
    this.fProject,
    this.amount,
    this.remarks,
    this.wDate,
    this.wMonth,
    this.wYear,
    this.wBy,
  });

  factory SaveWithDrawModel.fromJson(Map<String, dynamic> json) => SaveWithDrawModel(
    id: json["id"],
    compId: json["compId"],
    memNo: json["memNo"],
    fProject: json["fProject"],
    amount: json["amount"],
    remarks: json["remarks"],
    wDate: json["wDate"],
    wMonth: json["wMonth"],
    wYear: json["wYear"],
    wBy: json["wBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "compId": compId,
    "memNo": memNo,
    "fProject": fProject,
    "amount": amount,
    "remarks": remarks,
    "wDate": wDate,
    "wMonth": wMonth,
    "wYear": wYear,
    "wBy": wBy,
  };
}