import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    LoginResponse? data;

    LoginResponseModel({
        this.data,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        data: json["token"] == null ? null : LoginResponse.fromJson(json["token"]),
    );

    Map<String, dynamic> toJson() => {
        "token": data?.toJson(),
    };
}

class LoginResponse {
    String? token;
    String? username;
    String? fullname;
    String? role;
    String? cName;
    int? cId;

    LoginResponse({
        this.token,
        this.username,
        this.fullname,
        this.role,
        this.cName,
        this.cId,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        username: json["username"],
        fullname: json["fullname"],
        role: json["role"],
        cName: json["cName"],
        cId: json["cId"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "username": username,
        "fullname": fullname,
        "role": role,
        "cName": cName,
        "cId": cId,
    };
}

