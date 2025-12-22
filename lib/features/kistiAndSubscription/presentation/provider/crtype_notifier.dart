import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/domain/usecase/project_info_usecase.dart';

import '../../data/datasource/Model/CrtypeModel.dart';
import '../../domain/provider/kisty_usecase_provider.dart';
import '../../domain/usecase/crtype_usecase.dart';



class CrtypeNotifier extends AsyncNotifier<List<CrtypeModel>?> {
  late CrTypeUsecase crTypeUsecase;

  @override
  FutureOr<List<CrtypeModel>?> build() async {
    crTypeUsecase = await ref.read(crtypeUsecaseProvider.future);
    final result = await crTypeUsecase.call();
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

final projectInfoNotifierProvider = AsyncNotifierProvider<CrtypeNotifier, List<CrtypeModel>?>(() {
  return CrtypeNotifier();
});