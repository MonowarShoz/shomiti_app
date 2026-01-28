import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/Model/save_kisti_rec_body.dart';
import '../repository/accounts_repository.dart';

class SaveKistiReceiveUseCase {
  final AccountsRepository repository;

  SaveKistiReceiveUseCase(this.repository);

  Future<ApiResult<String?>> call({
    required SaveKistiReceiveBody kistiReceiveBody,
  }) {
    return repository.saveKistiReceive(
      kistiReceiveBody: kistiReceiveBody,
    );
  }
}