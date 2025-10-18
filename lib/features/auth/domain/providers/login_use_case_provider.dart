
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/features/auth/data/providers/login_data_provider.dart';
import 'package:imsomitiapp/features/auth/domain/usecase/change_password_usecase.dart';
import 'package:imsomitiapp/features/auth/domain/usecase/login_use_case.dart';

final loginUseCaseProvider = FutureProvider<LoginUseCase>((ref) async {
  final loginRepository = await ref.read(loginRepositoryProvider.future);
  return LoginUseCase(loginRepository);
});
// final chngPasswordUseCaseProvider = FutureProvider<ChangePasswordUsecase>((ref) async {
//   final loginRepository = await ref.read(loginRepositoryProvider.future);
//   return ChangePasswordUsecase(loginRepository);
// });
