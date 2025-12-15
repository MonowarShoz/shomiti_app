import 'dart:convert';

import 'package:imsomitiapp/core/networking/api_constants.dart';
import 'package:imsomitiapp/core/networking/api_error_handler.dart' show ApiErrorHandler;
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/local/home_local_data_source.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/member_info_remote_source.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_all_model.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_save_model.dart';
import 'package:imsomitiapp/features/Member_info/domain/repository/member_info_repository.dart';

class MemberInfoRepositoryImpl implements MemberInfoRepository {
  final HomeLocalDataSource localDataSource;
  final MemberInfoRemoteSource memberInfoRemoteSource;
  MemberInfoRepositoryImpl({required this.localDataSource,required this.memberInfoRemoteSource});

  @override
  Future<ApiResult<List<MemberInfoAllModel>?>> getAllMemberData() async{
    try {
        final token = await localDataSource.getToken();
    final userData = await localDataSource.getUserInformation();
    if ((token?.isEmpty ?? true) && (userData?.isEmpty ?? true)) {
      return ApiResult.failure(
        ApiErrorHandler.handle(ApiErrors.unauthorizedError),
        //ApiErrorHandler.handle(ApiErrorModel(code: 401,message: 'UnAuthorized')),
      );
    }
    final Map userJson = jsonDecode(userData!);
    final result = await memberInfoRemoteSource.memberInfoAll(token: 'Bearer $token', companyId: userJson['cid']);
    return result.when(success: (data) {
      if(data != null){
        return ApiResult.success(data);
      } else {
        return ApiResult.failure(ApiErrorHandler.handle(ApiErrors.noContent));
      }
      
    }, failure: (errorHandler) {
         return ApiResult.failure(ApiErrorHandler.handle(errorHandler));
    },);
    } catch (e) {
       return ApiResult.failure(ApiErrorHandler.handle(e));
    }
    
  }

  @override
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
  required int compId,
  }) async{
    try {
        final token = await localDataSource.getToken();
        if (token?.isEmpty ?? true) {
      return ApiResult.failure(
        ApiErrorHandler.handle(ApiErrors.unauthorizedError),
        //ApiErrorHandler.handle(ApiErrorModel(code: 401,message: 'UnAuthorized')),
      );
    }
    final result = await memberInfoRemoteSource.memberRegistration(token: 'Bearer $token', memberInfoSaveBody: MemberInfoSaveBody(
      memNo: 0,
      givenName: givenName,
      sureName: sureName,
      phone: phone,
      email: email,
      niD: niD,
      biCNo: biCNo,
      passportNo: passportNo,
      gender: gender,
      father: father,
      mother: mother,
      address: address,
      idenDocu: idenDocu,
      photo:photo,
      nationality: nationality,
      compId: compId
    ));
    return result.when(success: (data) {
        if (data != null) {
            final Map jsonData = jsonDecode(data);
            final successRes = jsonData["message"];
            print('success result $successRes');
            // if (successRes.toString().toLowerCase().contains('failed')) {
            //   return ApiResult.failure(ApiErrorHandler.handle('$successRes'));
            // } else {
              return ApiResult.success(successRes);
            //}
          } else {
            return ApiResult.failure(ApiErrorHandler.handle('No content'));
          }
    }, failure: (errorHandler) {
       String errorMessage = errorHandler.apiErrorModel.message ?? '';
        print('repoimpl reg error message $errorMessage');
          return ApiResult.failure(errorHandler);
    },);

    } catch (e) {
       return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}