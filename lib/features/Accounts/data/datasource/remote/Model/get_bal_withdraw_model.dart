import 'dart:convert';

List<GetBalanceWithdrawModel> getBalanceWithdrawModelFromJson(String str) => List<GetBalanceWithdrawModel>.from(json.decode(str).map((x) => GetBalanceWithdrawModel.fromJson(x)));

String getBalanceWithdrawModelToJson(List<GetBalanceWithdrawModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBalanceWithdrawModel {
  int? id;
  int? compId;
  int? memNo;
  int? fProject;
  String? projectName;
  int? amount;
  int? paid;
  int? due;
  String? remarks;
  String? wDate;
  String? wMonth;
  int? wYear;
  String? givenName;
  String? sureName;

  GetBalanceWithdrawModel({
    this.id,
    this.compId,
    this.memNo,
    this.fProject,
    this.projectName,
    this.amount,
    this.paid,
    this.due,
    this.remarks,
    this.wDate,
    this.wMonth,
    this.wYear,
    this.givenName,
    this.sureName,
  });

  factory GetBalanceWithdrawModel.fromJson(Map<String, dynamic> json) => GetBalanceWithdrawModel(
    id: json["id"],
    compId: json["compId"],
    memNo: json["memNo"],
    fProject: json["fProject"],
    projectName: json["projectName"],
    amount: json["amount"],
    paid: json["paid"],
    due: json["due"],
    remarks: json["remarks"],
    wDate: json["wDate"],
    wMonth: json["wMonth"],
    wYear: json["wYear"],
    givenName: json["givenName"],
    sureName: json["sureName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "compId": compId,
    "memNo": memNo,
    "fProject": fProject,
    "projectName": projectName,
    "amount": amount,
    "paid": paid,
    "due": due,
    "remarks": remarks,
    "wDate": wDate,
    "wMonth": wMonth,
    "wYear": wYear,
    "givenName": givenName,
    "sureName": sureName,
  };
}
