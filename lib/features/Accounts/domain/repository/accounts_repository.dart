import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/Model/balance_segment_save_model.dart';
import '../../data/datasource/remote/Model/get_bal_withdraw_model.dart';
import '../../data/datasource/remote/Model/save_withdraw_model.dart';

abstract class AccountsRepository {
  Future<ApiResult<String?>> saveBalanceSegmentInfo({required BalanceSegmentSaveModel balanceSegmentBody});
  Future<ApiResult<String?>> saveBalanceWithdraw({ required SaveWithDrawModel saveWithdrawData});
  Future<ApiResult<List<GetBalanceWithdrawModel>>> getBalWithdrawData({required int compID});
}