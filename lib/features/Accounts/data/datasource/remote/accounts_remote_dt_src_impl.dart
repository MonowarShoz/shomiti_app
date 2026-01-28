import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/balance_add_history_model.dart';

import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/balance_segment_save_model.dart';

import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/get_bal_withdraw_model.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/get_vendor_model.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/save_kisti_rec_body.dart';

import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/save_withdraw_model.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/total_balance_model.dart';

import '../../../../../core/base/remote_data_source.dart';
import 'accounts_remote_dt_source.dart';

class AccountsRemoteDtSourceImpl extends BaseRemoteDataSource implements AccountsRemoteDataSource {
  AccountsRemoteDtSourceImpl({required super.ref, required super.apiService});

  @override
  Future<ApiResult<List<GetBalanceWithdrawModel>>> getBalWithdrawData({required String token, required int compID}) {
    return safeApiCall(() async {
      return await apiService.getBalanceWithdraw(token, compID);
    });
  }

  @override
  Future<ApiResult<String?>> saveBalanceSegmentInfo({required String token, required BalanceSegmentSaveModel balanceSegmentBody}) {
    return safeApiCall(() async {
      return await apiService.saveBalance(token, balanceSegmentBody);
    });
  }

  @override
  Future<ApiResult<String?>> saveBalanceWithdraw({required String token, required SaveWithDrawModel saveWithdrawData}) {
    return safeApiCall(() async {
      return await apiService.saveWithdraw(token, saveWithdrawData);
    });
  }

  @override
  Future<ApiResult<List<BalanceAddHistoryModel>>> getBalanceAddHistory({required String token, required int companyId}) {
    // TODO: implement getBalanceAddHistory
    return safeApiCall(() async {
      return await apiService.getBalanceAddHistory(token, companyId);
    });
  }

  @override
  Future<ApiResult<List<TotalBalanceModel>>> getTotalBalance({required String token, required int companyId}) {
    return safeApiCall(() async {
      return await apiService.totalBalance(token, companyId);
    });
  }

  @override
  Future<ApiResult<List<GetVendorModel>>> getVendors({required String token}) {

    return safeApiCall(() async {
      return await apiService.vendorData(token);
    });
  }

  @override
  Future<ApiResult<String?>> saveKistiReceive({required String token, required SaveKistiReceiveBody body}) {
    return safeApiCall(() async {
      return await apiService.saveKistiReceive( token,  body);
    });
  }
}
