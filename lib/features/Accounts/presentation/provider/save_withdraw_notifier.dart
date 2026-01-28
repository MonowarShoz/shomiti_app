import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';

import '../../data/datasource/remote/Model/save_withdraw_model.dart';
import '../../domain/provider/accounts_usecase_provider.dart';

class SaveBalanceWithdrawNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async => false;

  Future<void> submit(SaveWithDrawModel body) async {
    state = const AsyncLoading();

    final useCase = await ref.read(saveBalanceWithdrawUseCaseProvider.future);

    final result = await useCase(saveWithdrawData: body);

    result.when(success: (_) => state = const AsyncData(true), failure: (error) => state = AsyncError(error, StackTrace.current));
  }
}

final saveBalanceWithdrawNotifierProvider = AsyncNotifierProvider<SaveBalanceWithdrawNotifier, bool>(SaveBalanceWithdrawNotifier.new);
