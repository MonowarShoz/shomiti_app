import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_response_model.dart';

abstract class LoginRemoteDataSource {
  Future<ApiResult<LoginResponseModel?>> login({required String username,required String password,});
 // Future<ApiResult<String?>> changePass({required String phone,required String currentpass,required String newpass}); 
} 