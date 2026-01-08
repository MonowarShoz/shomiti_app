import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../domain/provider/kisty_usecase_provider.dart';
import '../../domain/usecase/kisty_save_usecase.dart';

class KistySaveNotifier extends AsyncNotifier<String?> {
  late KistySaveUsecase kistySaveUsecase;

  @override
  FutureOr<String?> build() async {
    kistySaveUsecase = await ref.read(kistiSaveusecaseProvider.future);
    return null;
  }

  Future<void> saveKistyType({required int id, required String typeName, required int amount, required int projectId, required int creditId}) async {
    state = const AsyncLoading();
    final result = await kistySaveUsecase.call(id: id, typeName: typeName, amount: amount, projectId: projectId, crTypeId: creditId);
    result.when(
      success: (data) {
        if (data != null) {
          state = AsyncData(data);
        } else {
          state = AsyncError(ApiErrorHandler.handle("No Content"), StackTrace.current);
        }
      },
      failure: (errorHandler) {
        state = AsyncValue.error(errorHandler, StackTrace.current);
      },
    );
  }
}

final kistiTypeSaveNotiferProvider = AsyncNotifierProvider<KistySaveNotifier, String?>(() => KistySaveNotifier());
