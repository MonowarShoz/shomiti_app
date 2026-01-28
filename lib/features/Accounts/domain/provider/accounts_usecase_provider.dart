import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/provider/accounts_remote_data_src_provider.dart';
import '../usecase/getTotalBal_usecase.dart';
import '../usecase/get_bal_add_history_usecase.dart';
import '../usecase/get_balwithdraw_usecase.dart';
import '../usecase/get_vendor_usecase.dart';
import '../usecase/save_balance_usecase.dart';
import '../usecase/save_withdraw_usecase.dart';

final saveBalanceSegmentInfoUseCaseProvider = FutureProvider<SaveBalanceSegementUsecase>((ref) async {
  final repository = await ref.read(accountsRepositoryProvider.future);

  return SaveBalanceSegementUsecase(accountsRepository: repository);
});

final saveBalanceWithdrawUseCaseProvider = FutureProvider<SaveBalanceWithdrawUseCase>((ref) async {
  final repository = await ref.read(accountsRepositoryProvider.future);

  return SaveBalanceWithdrawUseCase(repository);
});

final getBalanceWithdrawDataUseCaseProvider = FutureProvider<GetBalanceWithdrawDataUseCase>((ref) async {
  final repository = await ref.read(accountsRepositoryProvider.future);

  return GetBalanceWithdrawDataUseCase(repository);
});
final getBalanceAddHistoryUseCaseProvider = FutureProvider<GetBalanceAddHistoryUseCase>((ref) async {
  final repository = await ref.read(accountsRepositoryProvider.future);

  return GetBalanceAddHistoryUseCase(repository);
});
final getTotalBalanceUseCaseProvider = FutureProvider<GetTotalBalanceUseCase>((ref) async {
  final repository = await ref.read(accountsRepositoryProvider.future);

  return GetTotalBalanceUseCase(repository);
});
final getVendorDataUseCaseProvider = FutureProvider<GetVendorsDataUseCase>((ref) async {
  final repository = await ref.read(accountsRepositoryProvider.future);

  return GetVendorsDataUseCase(repository);
});
