import 'dart:convert';

List<MenuModel> menuModelFromJson(String str) => List<MenuModel>.from(json.decode(str).map((x) => MenuModel.fromJson(x)));

String menuModelToJson(List<MenuModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuModel {
    int? id;
    String? menuName;
    dynamic parentId;
    String? menuUrl;
    int? sortOrder;
    int? level;
    String? fullPath;

    MenuModel({
        this.id,
        this.menuName,
        this.parentId,
        this.menuUrl,
        this.sortOrder,
        this.level,
        this.fullPath,
    });

    factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        id: json["id"],
        menuName: json["menuName"],
        parentId: json["parentId"],
        menuUrl: json["menuUrl"],
        sortOrder: json["sortOrder"],
        level: json["level"],
        fullPath: json["fullPath"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "menuName": menuName,
        "parentId": parentId,
        "menuUrl": menuUrl,
        "sortOrder": sortOrder,
        "level": level,
        "fullPath": fullPath,
    };
}