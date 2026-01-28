import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/Model/total_balance_model.dart';
import '../repository/accounts_repository.dart';

class GetTotalBalanceUseCase {
  final AccountsRepository repository;

  GetTotalBalanceUseCase(this.repository);

  Future<ApiResult<List<TotalBalanceModel>?>> call({
    required int compID,
  }) {
    return repository.getTotalBalance(compID: compID);
  }
}