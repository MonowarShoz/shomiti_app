import 'dart:convert';

List<GetProjectModel> getProjectModelFromJson(String str) => List<GetProjectModel>.from(json.decode(str).map((x) => GetProjectModel.fromJson(x)));

String getProjectModelToJson(List<GetProjectModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetProjectModel {
  int? id;
  int? projectId;
  String? projectName;
  String? proLocation;
  int? budget;
  int? diretorId;
  dynamic givenName;
  dynamic sureName;
  DateTime? startDate;
  DateTime? tentitiveEndDate;

  GetProjectModel({
    this.id,
    this.projectId,
    this.projectName,
    this.proLocation,
    this.budget,
    this.diretorId,
    this.givenName,
    this.sureName,
    this.startDate,
    this.tentitiveEndDate,
  });

  factory GetProjectModel.fromJson(Map<String, dynamic> json) => GetProjectModel(
    id: json["id"],
    projectId: json["projectId"],
    projectName: json["projectName"],
    proLocation: json["proLocation"],
    budget: json["budget"],
    diretorId: json["diretorId"],
    givenName: json["givenName"],
    sureName: json["sureName"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    tentitiveEndDate: json["tentitiveEndDate"] == null ? null : DateTime.parse(json["tentitiveEndDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "projectId": projectId,
    "projectName": projectName,
    "proLocation": proLocation,
    "budget": budget,
    "diretorId": diretorId,
    "givenName": givenName,
    "sureName": sureName,
    "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "tentitiveEndDate": "${tentitiveEndDate!.year.toString().padLeft(4, '0')}-${tentitiveEndDate!.month.toString().padLeft(2, '0')}-${tentitiveEndDate!.day.toString().padLeft(2, '0')}",
  };
}