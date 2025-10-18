import 'dart:async';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/utils/app_consts.dart';
import 'package:imsomitiapp/features/auth/presentation/provider/login_notifier_provider.dart';
import 'package:imsomitiapp/features/splash/domain/provider/splash_usecase_providers.dart';

class SplashNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() async {
    final useCase = await ref.watch(splashUseCaseProvider.future);
    final result = await useCase.call();
    await Future.delayed(Duration(seconds: AppConsts.splashDelay));
    return result.fold((failure) {
      //ref.read(authProvider.notifier).state = false;
      return false;
    }, (value) {
      //ref.read(authProvider.notifier).state = value;
      return value;

    } );
  }
}

final splashNotifierProvider = AsyncNotifierProvider<SplashNotifier, bool>(
  () => SplashNotifier(),
);
