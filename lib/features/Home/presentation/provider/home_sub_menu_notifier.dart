import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/child_menu_model.dart';
import 'package:imsomitiapp/features/Home/domain/Provider/home_usecase_provider.dart';
import 'package:imsomitiapp/features/Home/domain/usecase/child_menu_usecase.dart';

class SubMenuNotifier extends AsyncNotifier<List<ChildMenuModel>> {
  late final ChildMenuUsecase childMenuUsecase;
  @override
  FutureOr<List<ChildMenuModel>> build() async {
    childMenuUsecase = await ref.read(childMenuUsecaseProvider.future);
    return [];
  }

  Future<void> loadSubMenu(int parentID) async {
    state = AsyncValue.loading();
    final homeMenuUsecase = await ref.read(childMenuUsecaseProvider.future);
    final result = await homeMenuUsecase.call(parentID: parentID);
    result.when(
      success: (data) {
        return state = AsyncData(data ?? []);
      },
      failure: (errorHandler) {
        state = AsyncError(
          errorHandler.apiErrorModel.message ?? 'Unknown error',
          StackTrace.current,
        );
      },
    );
  }
}

final subMenuNotifierProvider = AsyncNotifierProvider<SubMenuNotifier, List<ChildMenuModel>>(() => SubMenuNotifier(),);
