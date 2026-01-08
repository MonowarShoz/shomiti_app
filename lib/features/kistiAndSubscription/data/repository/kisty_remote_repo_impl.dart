import 'dart:convert';

import 'package:imsomitiapp/core/base/remote_data_source.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/CrtypeModel.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/KistyTypeInfo.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/get_subscription_type_model.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/kistiInfoSaveModel.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/kisty_subs_remote_src.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/domain/repository/kisty_repository.dart';

import '../../../../core/helper/date_converter.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../Home/data/datasource/local/home_local_data_source.dart';

class KistyRepoImpl  implements KistyRepository {
  final HomeLocalDataSource localDataSource;
  final KistyRemoteSrc kistyRemoteSrc;
  KistyRepoImpl({required this.localDataSource,required this.kistyRemoteSrc});

  @override
  Future<ApiResult<List<CrtypeModel>?>> getCrtypeList() async{
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
      final result = await kistyRemoteSrc.getCrtype(token: 'Bearer $token', );
      return result.when(
        success: (data) {
          if (data != null) {
            return ApiResult.success(data);
          } else {
            return ApiResult.failure(ApiErrorHandler.handle(ApiErrors.noContent));
          }
        },
        failure: (errorHandler) {
          return ApiResult.failure(ApiErrorHandler.handle(errorHandler));
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }


  }

  @override
  Future<ApiResult<List<KistyTypeInfo>?>> getKistyTypeList() async{
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
      final result = await kistyRemoteSrc.getKistyTypeData( 'Bearer $token', userJson['cid']);
      return result.when(
        success: (data) {
          if (data != null) {
            return ApiResult.success(data);
          } else {
            return ApiResult.failure(ApiErrorHandler.handle(ApiErrors.noContent));
          }
        },
        failure: (errorHandler) {
          return ApiResult.failure(ApiErrorHandler.handle(errorHandler));
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<String?>> saveKistyType({required int id,required String typeName, required int amount, required int crTypeId, required int projectId}) async{

    try{
      final token = await localDataSource.getToken();
      final userData = await localDataSource.getUserInformation();
      if ((token?.isEmpty ?? true) && (userData?.isEmpty ?? true)) {
        return ApiResult.failure(
          ApiErrorHandler.handle(ApiErrors.unauthorizedError),
          //ApiErrorHandler.handle(ApiErrorModel(code: 401,message: 'UnAuthorized')),
        );
      }
      final Map userJson = jsonDecode(userData!);
      final result = await kistyRemoteSrc.saveKistyType(token: 'Bearer $token', kistiTypeBody: KistiSaveModel(
        id: id,
        typeName: typeName,
        amount: amount,
        compId: userJson['cid'],
        crid: crTypeId,
        projectid: projectId,
        createdate: DateConverter.dateFormatStyle2(DateTime.now()),
        updatedate: DateConverter.dateFormatStyle2(DateTime.now()),
      ));
      return result.when(
        success: (data) {
          if (data != null) {
            // final Map jsonData = jsonDecode(data);
            // final successRes = jsonData["message"];
            print('success result $data');
            // if (successRes.toString().toLowerCase().contains('failed')) {
            //   return ApiResult.failure(ApiErrorHandler.handle('$successRes'));
            // } else {
            return ApiResult.success(data);
            //}
          } else {
            return ApiResult.failure(ApiErrorHandler.handle('No content'));
          }
        },
        failure: (errorHandler) {
          String errorMessage = errorHandler.apiErrorModel.message ?? '';
          print('repoimpl reg error message $errorMessage');
          return ApiResult.failure(errorHandler);
        },
      );
    }catch(e){
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<String?>> addSubsctiptionType({required int id, required int crTypeId, required String typeName, required int projectId, required int amount}) {
    // TODO: implement addSubsctiptionType
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<GetSubscriptionTypeModel>?>> getSubsctipTypeData() {
    // TODO: implement getSubsctipTypeData
    throw UnimplementedError();
  }
  
  
}