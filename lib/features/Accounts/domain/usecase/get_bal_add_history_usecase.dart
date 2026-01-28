import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/Model/balance_add_history_model.dart';
import '../repository/accounts_repository.dart';

class GetBalanceAddHistoryUseCase {
  final AccountsRepository repository;

  GetBalanceAddHistoryUseCase(this.repository);

  Future<ApiResult<List<BalanceAddHistoryModel>?>> call({
    required int compID,
  }) {
    return repository.getBalanceAddHistory(compID: compID);
  }
}