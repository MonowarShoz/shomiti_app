import 'package:imsomitiapp/features/Accounts/domain/repository/accounts_repository.dart';

import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/Model/balance_segment_save_model.dart';

class AccBalanceUsecase {
  final AccountsRepository accountsRepository;
  AccBalanceUsecase({required this.accountsRepository});

  Future<ApiResult<String?>> call({required BalanceSegmentSaveModel balanceSegmentBody}) async{
    return accountsRepository.saveBalanceSegmentInfo(balanceSegmentBody: balanceSegmentBody);

  }
}