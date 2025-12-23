import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';

import '../../data/datasource/Model/KistyTypeInfo.dart';
import '../../domain/provider/kisty_usecase_provider.dart';
import '../../domain/usecase/kisty_type_info_usecase.dart';

class KistiInfoNotifier extends AsyncNotifier<List<KistyTypeInfo>> {
  late KistyTypeInfoUsecase kistyTypeInfoUsecase;

  @override
  FutureOr<List<KistyTypeInfo>> build() async {
    kistyTypeInfoUsecase = await ref.read(kistiInfoUsecaseProvider.future);
    final result = await kistyTypeInfoUsecase.call();
    return result.when(
      success: (data) {
        return data ?? [];
      },
      failure: (errorHandler) {
        throw errorHandler;
      },
    );
  }
}

final kistiInfoNotifierProvider = AsyncNotifierProvider<KistiInfoNotifier, List<KistyTypeInfo>>(() {
  return KistiInfoNotifier();
});