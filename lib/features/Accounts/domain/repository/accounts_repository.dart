import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/Model/balance_add_history_model.dart';
import '../../data/datasource/remote/Model/balance_segment_save_model.dart';
import '../../data/datasource/remote/Model/get_bal_withdraw_model.dart';
import '../../data/datasource/remote/Model/get_vendor_model.dart';
import '../../data/datasource/remote/Model/save_kisti_rec_body.dart';
import '../../data/datasource/remote/Model/save_withdraw_model.dart';
import '../../data/datasource/remote/Model/total_balance_model.dart';

abstract class AccountsRepository {
  Future<ApiResult<String?>> saveBalanceSegmentInfo({required BalanceSegmentSaveModel balanceSegmentBody});
  Future<ApiResult<String?>> saveBalanceWithdraw({ required SaveWithDrawModel saveWithdrawData});
  Future<ApiResult<List<GetBalanceWithdrawModel>>> getBalWithdrawData({required int compID});
  /// Get balance add history
  Future<ApiResult<List<BalanceAddHistoryModel>>> getBalanceAddHistory({
    required int compID,
  });

  /// Get total account balance
  Future<ApiResult<List<TotalBalanceModel>>> getTotalBalance({
    required int compID,
  });

  /// Get vendor list
  Future<ApiResult<List<GetVendorModel>>> getVendors();

  /// Save kisti receive
  Future<ApiResult<String?>> saveKistiReceive({
    required SaveKistiReceiveBody kistiReceiveBody,
  });
}