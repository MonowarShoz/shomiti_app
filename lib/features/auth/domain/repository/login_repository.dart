
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_response_model.dart';
import 'package:imsomitiapp/features/auth/domain/entities/user.dart';

abstract class LoginRepository {
  Future<ApiResult<LoginResponse>> login({required String phone,required String password, String? deviceToken});
  //Future<ApiResult<String?>> changePassword({required String phone,required String currpassword,required String newpass});
}
