import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';

import '../../data/datasource/remote/Model/total_balance_model.dart';
import '../../domain/provider/accounts_usecase_provider.dart';

class GetTotalBalanceNotifier
    extends AsyncNotifier<List<TotalBalanceModel>> {
  @override
  Future<List<TotalBalanceModel>> build() async => [];

  Future<void> load(int compId) async {
    state = const AsyncLoading();

    final useCase =
    await ref.read(getTotalBalanceUseCaseProvider.future);

    final result = await useCase.call(compID: compId);

    result.when(
      success: (data) => state = AsyncData(data ?? []),
      failure: (error) =>
      state = AsyncError(error, StackTrace.current),
    );
  }
}

final getTotalBalanceNotifierProvider =
AsyncNotifierProvider<GetTotalBalanceNotifier,
    List<TotalBalanceModel>>(
  GetTotalBalanceNotifier.new,
);