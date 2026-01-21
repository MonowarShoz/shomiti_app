import 'dart:convert';

import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/balance_add_history_model.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/balance_segment_save_model.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/get_bal_withdraw_model.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/get_vendor_model.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/save_kisti_rec_body.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/save_withdraw_model.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/total_balance_model.dart';
import 'package:imsomitiapp/features/Accounts/domain/repository/accounts_repository.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../Home/data/datasource/local/home_local_data_source.dart';
import '../datasource/remote/accounts_remote_dt_source.dart';

class AccountRepositoryImpl extends AccountsRepository{
  final HomeLocalDataSource localDataSource;
  final AccountsRemoteDataSource accountsRemoteDataSource;
  AccountRepositoryImpl({required this.localDataSource, required this.accountsRemoteDataSource});
  @override
  Future<ApiResult<List<GetBalanceWithdrawModel>>> getBalWithdrawData({required int compID}) {
    // TODO: implement getBalWithdrawData
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<String?>> saveBalanceSegmentInfo({required BalanceSegmentSaveModel balanceSegmentBody}) async{
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
      final result = await accountsRemoteDataSource.saveBalanceSegmentInfo(token: 'Bearer $token', balanceSegmentBody: BalanceSegmentSaveModel(
        id: balanceSegmentBody.id,
        compId: userJson['cid'],
        vendor: balanceSegmentBody.vendor,
        amount: balanceSegmentBody.amount,
        createDate: balanceSegmentBody.createDate,
        descri: balanceSegmentBody.descri

      ));
      return result.when(success: (data) {
        if(data != null){
          return ApiResult.success(data);
        }else{
          return ApiResult.failure(ApiErrorHandler.handle('No content'));
        }
      }, failure: (errorHandler) {
       return ApiResult.failure(errorHandler);
      },);
    }catch(e){
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<String?>> saveBalanceWithdraw({required SaveWithDrawModel saveWithdrawData}) {
    // TODO: implement saveBalanceWithdraw
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<BalanceAddHistoryModel>>> getBalanceAddHistory({required int compID}) {
    // TODO: implement getBalanceAddHistory
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<TotalBalanceModel>>> getTotalBalance({required int compID}) {
    // TODO: implement getTotalBalance
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<GetVendorModel>>> getVendors() {
    // TODO: implement getVendors
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<String?>> saveKistiReceive({required SaveKistiReceiveBody kistiReceiveBody}) {
    // TODO: implement saveKistiReceive
    throw UnimplementedError();
  }

}