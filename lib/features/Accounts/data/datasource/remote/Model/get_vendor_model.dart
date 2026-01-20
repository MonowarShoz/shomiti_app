import 'dart:convert';

List<GetVendorModel> getVendorModelFromJson(String str) => List<GetVendorModel>.from(json.decode(str).map((x) => GetVendorModel.fromJson(x)));

String getVendorModelToJson(List<GetVendorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetVendorModel {
  int? id;
  String? vType;

  GetVendorModel({
    this.id,
    this.vType,
  });

  factory GetVendorModel.fromJson(Map<String, dynamic> json) => GetVendorModel(
    id: json["id"],
    vType: json["vType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vType": vType,
  };
}