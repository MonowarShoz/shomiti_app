import 'dart:convert';

List<ParentMenuModel> parentMenuModelFromJson(String str) => List<ParentMenuModel>.from(json.decode(str).map((x) => ParentMenuModel.fromJson(x)));

String parentMenuModelToJson(List<ParentMenuModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParentMenuModel {
    int? id;
    String? menuName;
    int? sortOrder;

    ParentMenuModel({
        this.id,
        this.menuName,
        this.sortOrder,
    });

    factory ParentMenuModel.fromJson(Map<String, dynamic> json) => ParentMenuModel(
        id: json["id"],
        menuName: json["menuName"],
        sortOrder: json["sortOrder"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "menuName": menuName,
        "sortOrder": sortOrder,
    };
}