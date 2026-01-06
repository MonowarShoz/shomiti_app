import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/balance_segment_save_model.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/Model/get_bal_withdraw_model.dart';

import 'Model/save_withdraw_model.dart';

abstract class AccountsRemoteDataSource {
  Future<ApiResult<String?>> saveBalanceSegmentInfo({required String token, required BalanceSegmentSaveModel balanceSegmentBody});
  Future<ApiResult<String?>> saveBalanceWithdraw({required String token, required SaveWithDrawModel saveWithdrawData});
  Future<ApiResult<List<GetBalanceWithdrawModel>>> getBalWithdrawData({required String token, required int compID});

}
