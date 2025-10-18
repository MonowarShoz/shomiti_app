import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/helper/extensions.dart';
import 'package:imsomitiapp/core/routing/routes.dart';
import 'package:imsomitiapp/core/theming/app_assets.dart';
import 'package:imsomitiapp/core/theming/colors_manager.dart';
import 'package:imsomitiapp/features/auth/presentation/provider/login_notifier_provider.dart';
import 'package:imsomitiapp/features/splash/presentation/provider/splash_notifier.dart';

class SplashScreeen extends ConsumerWidget {
  const SplashScreeen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(splashNotifierProvider, (previous, next) {
      print('auth provider ${ref.read(authProvider.notifier).state}');
      next.whenOrNull(
        data: (isLoggedIn) {
          print('Hello from Splash screen $isLoggedIn');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isLoggedIn
                ? context.goNamed(Routes.home)
                : context.goNamed(Routes.loginScreen);
          });
        },
        error: (error, stackTrace) {
          print('splash error ${error.toString()}');
        },
      );
    });
    //  final splashState = ref.watch(splashNotifierProvider);

    // splashState.when(
    //   data: (isLoggedIn) {
    //     // Update global auth state
    //     ref.read(authProvider.notifier).state = isLoggedIn;
    //     // Navigation is handled by GoRouter.redirect
    //   },
    //   loading: () {
    //     // You can show a loader here if you want
    //   },
    //   error: (error, stackTrace) {
    //     debugPrint('Splash error: $error');
    //     ref.read(authProvider.notifier).state = false;
    //   },
    // );
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(child: Center(child: Image.asset(AppAssets.appLogo,fit: BoxFit.cover,height: 100,width: 100,))),
    );
  }
}
