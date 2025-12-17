import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/parent_menu_model.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_all_model.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_save_model.dart';

abstract class MemberInfoRepository {
 Future<ApiResult<String?>> memberRegistration({
  required String givenName,
  String? sureName,
  required String phone,
  String? email,
  String? niD,
  String? biCNo,
  String? passportNo,
  String? nationality,
  int? gender,
  String? father,
  String? mother,
  String? address,
  String? idenDocu,
  String? photo,

 });
  Future<ApiResult<List<MemberInfoAllModel>?>> getAllMemberData();
}