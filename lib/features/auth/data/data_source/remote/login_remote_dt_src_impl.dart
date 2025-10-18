import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/remote_data_source.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/core/networking/api_service.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/login_remote_dt_src.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_request_model.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_response_model.dart';

class LoginRemoteDtSrcImpl extends BaseRemoteDataSource
    implements LoginRemoteDataSource {
  LoginRemoteDtSrcImpl({required super.apiService,required super.ref});
  @override
  Future<ApiResult<LoginResponseModel?>> login(
   {required String username,
   required String password,
    }
  ) async {
    return await safeApiCall(() async {
      return await apiService.login(
        LoginRequestModel(username: username,password:password ),
      );
    });
  }
  
  // @override
  // Future<ApiResult<String?>> changePass({required String phone, required String currentpass, required String newpass}) async{
  //   return await safeApiCall(() async {
  //     return await apiService.changePassword(
  //      phone,currentpass,newpass
  //     );
  //   });
  // }
}
