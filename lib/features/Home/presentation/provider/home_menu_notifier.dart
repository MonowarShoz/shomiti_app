import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/parent_menu_model.dart';
import 'package:imsomitiapp/features/Home/domain/Provider/home_usecase_provider.dart';

class HomeParentMenuNotifier extends AsyncNotifier<List<ParentMenuModel>> {
  @override
  FutureOr<List<ParentMenuModel>> build() async {
    ref.keepAlive();
    final homeMenuUsecase = await ref.read(parentMenuUsecaseProvider.future);
    final result = await homeMenuUsecase.call();
    return result.when(
      success: (data) {
       
        return data ?? [];
      },
      failure: (errorHandler) async{
        print('Home Menu Error');
        print('statusCode ${errorHandler.apiErrorModel.code}');
        final statusCode= errorHandler.apiErrorModel.code;
         if (statusCode == 401) {
          // ref.read(authStatusProvider.notifier).state =
          //     AuthStatus.unauthenticated;
         //await ref.read(logOutNotifierProvider.notifier).logOut();
          
          throw errorHandler.apiErrorModel.message ?? "401, Unauthenticated";
        } else {
          print('logo error message $statusCode');
          throw errorHandler.apiErrorModel.message ?? "Failed to Load menu";
        }
        // return [];
       
      },
    );
  }
}

final homeparentMenuNotifierProvider =
    AsyncNotifierProvider<HomeParentMenuNotifier, List<ParentMenuModel>>(
      () => HomeParentMenuNotifier(),
    );

//     final optionAvailableProvider = FutureProvider<bool>((ref) async {
//   final userInfo = await ref.read(homeUserInfonotifierProvider.future);
//   final roleId = userInfo['roleId'];
//   return roleId == '1' || roleId =='2';
// });
