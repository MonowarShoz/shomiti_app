import 'dart:convert';

List<ChildMenuModel> childMenuModelFromJson(String str) => List<ChildMenuModel>.from(json.decode(str).map((x) => ChildMenuModel.fromJson(x)));

String childMenuModelToJson(List<ChildMenuModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildMenuModel {
    int? id;
    int? parentId;
    String? menuName;
    String? menuUrl;

    ChildMenuModel({
        this.id,
        this.parentId,
        this.menuName,
        this.menuUrl,
    });

    factory ChildMenuModel.fromJson(Map<String, dynamic> json) => ChildMenuModel(
        id: json["id"],
        parentId: json["parentId"],
        menuName: json["menuName"],
        menuUrl: json["menuUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parentId": parentId,
        "menuName": menuName,
        "menuUrl": menuUrl,
    };
}