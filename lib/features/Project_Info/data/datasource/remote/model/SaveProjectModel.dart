import 'dart:convert';

SaveProjectModel saveProjectModelFromJson(String str) => SaveProjectModel.fromJson(json.decode(str));

String saveProjectModelToJson(SaveProjectModel data) => json.encode(data.toJson());

class SaveProjectModel {
  int? id;
  int? projectId;
  int? compId;
  String? projectName;
  String? proLocation;
  int? budget;
  int? diretorId;
  String? startDate;
  String? tentitiveEndDate;

  SaveProjectModel({
    this.id,
    this.projectId,
    this.compId,
    this.projectName,
    this.proLocation,
    this.budget,
    this.diretorId,
    this.startDate,
    this.tentitiveEndDate,
  });

  factory SaveProjectModel.fromJson(Map<String, dynamic> json) => SaveProjectModel(
    id: json["id"],
    projectId: json["projectId"],
    compId: json["compId"],
    projectName: json["projectName"],
    proLocation: json["proLocation"],
    budget: json["budget"],
    diretorId: json["diretorId"],
    startDate: json["startDate"],
    tentitiveEndDate: json["tentitiveEndDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "projectId": projectId,
    "compId": compId,
    "projectName": projectName,
    "proLocation": proLocation,
    "budget": budget,
    "diretorId": diretorId,
    "startDate": startDate,
    "tentitiveEndDate": tentitiveEndDate,
  };
}