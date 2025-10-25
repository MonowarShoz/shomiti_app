

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsomitiapp/core/routing/app_router.dart';
import 'package:imsomitiapp/core/theming/app_theme.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  // final container = ProviderContainer();
  //  final fcmService = container.read(fcmServiceProvider);
  // fcmService.setProviderContainer(container);
  // await fcmService.initialize();
  runApp(
    ProviderScope(child: ShomitiApp()),
  );
  //runApp(ProviderScope(child: SchoolNotebookApp()));
}



class ShomitiApp extends ConsumerWidget {
  const ShomitiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    // ref.listen<AuthStatus>(authStatusProvider, (previous, next) {
    //   if (next == AuthStatus.unauthenticated ) {
    //     // Make sure you use GoRouter's context, not MaterialApp context
    //     router.goNamed(Routes.loginScreen);
    //   }
    // });
    return ScreenUtilInit(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Smart somobay',
        theme: AppTheme.lightTheme,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        routerConfig: router,
      ),
    );
  }
}
