import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/Model/get_bal_withdraw_model.dart';
import '../repository/accounts_repository.dart';

class GetBalanceWithdrawDataUseCase {
  final AccountsRepository repository;

  GetBalanceWithdrawDataUseCase(this.repository);

  Future<ApiResult<List<GetBalanceWithdrawModel>?>> call({
    required int compID,
  }) {
    return repository.getBalWithdrawData(compID: compID);
  }
}