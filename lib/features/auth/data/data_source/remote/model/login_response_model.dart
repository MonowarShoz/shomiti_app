import 'dart:convert';

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    String? token;
    String? role;
    String? fullname;
    String? username;
    String? cname;
    int? cid;
    String? message;

    LoginResponseModel({
        this.token,
        this.role,
        this.fullname,
        this.username,
        this.cname,
        this.cid,
        this.message,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        token: json["token"],
        role: json["role"],
        fullname: json["fullname"],
        username: json["username"],
        cname: json["cname"],
        cid: json["cid"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "role": role,
        "fullname": fullname,
        "username": username,
        "cname": cname,
        "cid": cid,
        "message": message,
    };
}
