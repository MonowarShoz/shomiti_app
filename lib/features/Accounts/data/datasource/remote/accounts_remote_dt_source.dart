import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/balance_segment_save_model.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/get_bal_withdraw_model.dart';

import 'Model/balance_add_history_model.dart';
import 'Model/get_vendor_model.dart';
import 'Model/save_kisti_rec_body.dart';
import 'Model/save_withdraw_model.dart';
import 'Model/total_balance_model.dart';

abstract class AccountsRemoteDataSource {
  Future<ApiResult<String?>> saveBalanceSegmentInfo({required String token, required BalanceSegmentSaveModel balanceSegmentBody});

  Future<ApiResult<String?>> saveBalanceWithdraw({required String token, required SaveWithDrawModel saveWithdrawData});

  Future<ApiResult<List<GetBalanceWithdrawModel>>> getBalWithdrawData({required String token, required int compID});

  Future<List<BalanceAddHistoryModel>> getBalanceAddHistory({required String token, required int companyId});

  Future<List<TotalBalanceModel>> getTotalBalance({required String token, required int companyId});

  Future<List<GetVendorModel>> getVendors({required String token});

  Future<String> saveKistiReceive({required String token, required SaveKistiReceiveBody body});
}
