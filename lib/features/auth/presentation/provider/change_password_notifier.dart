// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:school_notebook/core/networking/api_result.dart';
// import 'package:school_notebook/core/utils/app_strings.dart';
// import 'package:school_notebook/features/auth/domain/providers/login_use_case_provider.dart';
// import 'package:school_notebook/features/auth/domain/usecase/change_password_usecase.dart';

// class ChangePasswordNotifier extends AsyncNotifier<String?> {
//   late final ChangePasswordUsecase changePasswordUsecase;
//   @override
//   FutureOr<String?> build() async {
//     changePasswordUsecase = await ref.read(chngPasswordUseCaseProvider.future);
//     return null;
//   }

//   Future<void> changeCurrentPassword({required String phone, required String currentpass, required String newpass}) async {
//     state = const AsyncLoading();
//     final result = await changePasswordUsecase.call(phone: phone, password: currentpass, newpass: newpass);
//     result.when(
//       success: (data) {
//         state = AsyncData(data);
//       },
//       failure: (errorHandler) {
//         state = AsyncValue.error(errorHandler.apiErrorModel.message ?? AppStrings.unexpectedError, StackTrace.current);
//       },
//     );
//   }
// }

// final changePasswordNotifierProvider = AsyncNotifierProvider<ChangePasswordNotifier, String?>(() => ChangePasswordNotifier());
