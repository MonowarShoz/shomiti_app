import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';

import '../../data/datasource/remote/Model/get_bal_withdraw_model.dart';
import '../../domain/provider/accounts_usecase_provider.dart';


class GetBalanceWithdrawNotifier
    extends AsyncNotifier<List<GetBalanceWithdrawModel>> {
  @override
  Future<List<GetBalanceWithdrawModel>> build() async {
    // initial empty list
    return [];
  }

  Future<void> load(int compID) async {
    state = const AsyncLoading();

    final useCase =
    await ref.read(getBalanceWithdrawDataUseCaseProvider.future);

    final result = await useCase(compID: compID);

    result.when(
      success: (data) {
        state = AsyncData(data ?? []);
      },
      failure: (error) {
        state = AsyncError(error, StackTrace.current);
      },
    );
  }
}

final getBalanceWithdrawNotifierProvider =
AsyncNotifierProvider<GetBalanceWithdrawNotifier,
    List<GetBalanceWithdrawModel>>(
  GetBalanceWithdrawNotifier.new,
);
