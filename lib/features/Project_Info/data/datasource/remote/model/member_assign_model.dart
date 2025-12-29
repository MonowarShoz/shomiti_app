import 'dart:convert';

MemberAssignBody memberAssignBodyFromJson(String str) => MemberAssignBody.fromJson(json.decode(str));

String memberAssignBodyToJson(MemberAssignBody data) => json.encode(data.toJson());

class MemberAssignBody {
  int? id;
  int? projectId;
  int? memNo;
  int? amount;
  int? compId;
  String? assignBy;

  MemberAssignBody({
    this.id,
    this.projectId,
    this.memNo,
    this.amount,
    this.compId,
    this.assignBy,
  });

  factory MemberAssignBody.fromJson(Map<String, dynamic> json) => MemberAssignBody(
    id: json["id"],
    projectId: json["projectId"],
    memNo: json["memNo"],
    amount: json["amount"],
    compId: json["compId"],
    assignBy: json["assignBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "projectId": projectId,
    "memNo": memNo,
    "amount": amount,
    "compId": compId,
    "assignBy": assignBy,
  };
}