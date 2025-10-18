
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/features/splash/data/provider/splash_data_provider.dart';
import 'package:imsomitiapp/features/splash/domain/usecase/check_user_connection_use_case.dart';

final splashUseCaseProvider = FutureProvider<CheckUserConnectionUseCase>((
  ref,
) async {
  final repository = await ref.read(splashRepositoryProvider.future);
  return CheckUserConnectionUseCase(repository);
});
