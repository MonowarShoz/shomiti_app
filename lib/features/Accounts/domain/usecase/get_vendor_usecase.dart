import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/Model/get_vendor_model.dart';
import '../repository/accounts_repository.dart';

class GetVendorsDataUseCase {
  final AccountsRepository repository;

  GetVendorsDataUseCase(this.repository);

  Future<ApiResult<List<GetVendorModel>?>> call() {
    return repository.getVendors();
  }
}