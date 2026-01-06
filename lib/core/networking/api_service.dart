import 'package:dio/dio.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/child_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/parent_menu_model.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_all_model.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_save_model.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/SaveProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/get_member_assign_model.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_request_model.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_response_model.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/CrtypeModel.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/kistiInfoSaveModel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:imsomitiapp/core/networking/api_constants.dart';

import '../../features/Accounts/data/datasource/remote/Model/balance_segment_save_model.dart';
import '../../features/Accounts/data/datasource/remote/Model/get_bal_withdraw_model.dart';
import '../../features/Accounts/data/datasource/remote/Model/save_withdraw_model.dart';
import '../../features/Project_Info/data/datasource/remote/model/member_assign_model.dart';
import '../../features/kistiAndSubscription/data/datasource/Model/KistyTypeInfo.dart';
import '../../features/kistiAndSubscription/data/datasource/Model/get_subscription_type_model.dart';
import '../../features/kistiAndSubscription/data/datasource/Model/save_subscription_type_body.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel loginRequestBody);

  @GET(ApiConstants.parentmenuRoute)
  Future<List<ParentMenuModel>> getParentUserMenu(@Header("Authorization") String token, @Query("compId") int compId);

  @GET(ApiConstants.childmenuRoute)
  Future<List<ChildMenuModel>> getChilUserMenu(@Header("Authorization") String token, @Query("parentid") int parentId);

  @GET(ApiConstants.memberInfoAll)
  Future<List<MemberInfoAllModel>> getAllMemberInfoData(@Header("Authorization") String token, @Query("compId") int companyId);

  @POST(ApiConstants.memberRegistration)
  Future<String> memberRegistration(@Header("Authorization") String token, @Body() MemberInfoSaveBody memberInfoSaveBody);

  //Kisty
  @POST(ApiConstants.savekistiType)
  Future<String> kistiTypeSave(@Header("Authorization") String token, @Body() KistiSaveModel kistiSaveBody);

  @GET(ApiConstants.kistiType)
  Future<List<KistyTypeInfo>> getKistypeInfo(@Header("Authorization") String token, @Query("compId") int companyId);

  @GET(ApiConstants.crType)
  Future<List<CrtypeModel>> getCrtype(@Header("Authorization") String token);

  @GET(ApiConstants.getsubscriptiontypes)
  Future<List<GetSubscriptionTypeModel>> getSubsriptionType(@Header("Authorization") String token, @Query("compId") int companyId);

  @POST(ApiConstants.subscriptionTypeEntry)
  Future<String> saveSubscriptionType(@Header("Authorization") String token, @Body() SaveSubscriptionTypeBody saveSubscriptionTypeBody);

  //project
  @GET(ApiConstants.projectInfo)
  Future<List<GetProjectModel>> getProjectData(@Header("Authorization") String token, @Query("compId") int companyId);

  @POST(ApiConstants.saveproject)
  Future<String> saveProject(@Header("Authorization") String token, @Body() SaveProjectModel saveProjectBody);

  @POST(ApiConstants.saveassignproject)
  Future<String> memberAssign(@Header("Authorization") String token, @Body() MemberAssignBody memberAssignBody);

  @GET(ApiConstants.getassign)
  Future<List<MemberAssigninfoModel>> getMemberAssign(@Header("Authorization") String token, @Query("compId") int companyId);

  //Accounts
  @GET(ApiConstants.getBalanceWithdraw)
  Future<List<GetBalanceWithdrawModel>> getBalanceWithdraw(@Header("Authorization") String token, @Query("compId") int companyId);
  @POST(ApiConstants.saveBalanceSegment)
  Future<String> saveBalance(@Header("Authorization") String token, @Body() BalanceSegmentSaveModel balanceSegmentSaveBody);
  @POST(ApiConstants.saveBalanceWithdraw)
  Future<String> saveWithdraw(@Header("Authorization") String token, @Body() SaveWithDrawModel saveWithdrawBody);

}
