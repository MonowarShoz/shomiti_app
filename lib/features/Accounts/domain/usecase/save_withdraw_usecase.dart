import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/Model/save_withdraw_model.dart';
import '../repository/accounts_repository.dart';

class SaveBalanceWithdrawUseCase {
  final AccountsRepository repository;

  SaveBalanceWithdrawUseCase(this.repository);

  Future<ApiResult<String?>> call({
    required SaveWithDrawModel saveWithdrawData,
  }) {
    return repository.saveBalanceWithdraw(
      saveWithdrawData: saveWithdrawData,
    );
  }
}