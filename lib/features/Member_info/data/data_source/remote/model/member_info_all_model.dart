import 'dart:convert';

List<MemberInfoAllModel> memberInfoAllModelFromJson(String str) => List<MemberInfoAllModel>.from(json.decode(str).map((x) => MemberInfoAllModel.fromJson(x)));

String memberInfoAllModelToJson(List<MemberInfoAllModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberInfoAllModel {
    int? memNo;
    String? givenName;
    String? sureName;
    String? phone;
    String? email;
    String? niD;
    String? biCNo;
    String? passportNo;
    String? nationality;
    int? genderId;
    String? gender;
    String? father;
    String? mother;
    String? address;
    String? idenDocu;
    String? photo;
    String? createDate;
    String? createBy;
    String? updateDate;
    int? compId;

    MemberInfoAllModel({
        this.memNo,
        this.givenName,
        this.sureName,
        this.phone,
        this.email,
        this.niD,
        this.biCNo,
        this.passportNo,
        this.nationality,
        this.genderId,
        this.gender,
        this.father,
        this.mother,
        this.address,
        this.idenDocu,
        this.photo,
        this.createDate,
        this.createBy,
        this.updateDate,
        this.compId,
    });

    factory MemberInfoAllModel.fromJson(Map<String, dynamic> json) => MemberInfoAllModel(
        memNo: json["memNo"],
        givenName: json["givenName"],
        sureName: json["sureName"],
        phone: json["phone"],
        email: json["email"],
        niD: json["niD"],
        biCNo: json["biCNo"],
        passportNo: json["passportNo"],
        nationality: json["nationality"],
        genderId: json["genderId"],
        gender: json["gender"],
        father: json["father"],
        mother: json["mother"],
        address: json["address"],
        idenDocu: json["idenDocu"],
        photo: json["photo"],
        createDate: json["createDate"],
        createBy: json["createBy"],
        updateDate: json["updateDate"],
        compId: json["compId"],
    );

    Map<String, dynamic> toJson() => {
        "memNo": memNo,
        "givenName": givenName,
        "sureName": sureName,
        "phone": phone,
        "email": email,
        "niD": niD,
        "biCNo": biCNo,
        "passportNo": passportNo,
        "nationality": nationality,
        "genderId": genderId,
        "gender": gender,
        "father": father,
        "mother": mother,
        "address": address,
        "idenDocu": idenDocu,
        "photo": photo,
        "createDate": createDate,
        "createBy": createBy,
        "updateDate": updateDate,
        "compId": compId,
    };
}