import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:imsomitiapp/core/routing/navigator_observer.dart';
import 'package:imsomitiapp/core/routing/routes.dart';
import 'package:imsomitiapp/features/Home/presentation/widget/home_screen.dart';
import 'package:imsomitiapp/features/Home/presentation/widget/submenu_screen.dart';
import 'package:imsomitiapp/features/Member_info/presentation/widget/member_registration_form.dart';
import 'package:imsomitiapp/features/Project_Info/presentation/widget/project_info_screen.dart';
import 'package:imsomitiapp/features/auth/presentation/provider/login_notifier_provider.dart';
import 'package:imsomitiapp/features/auth/presentation/widget/login_screen.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/presentation/widget/kisti_info_screen.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/presentation/widget/kisti_save_screen.dart';
import 'package:imsomitiapp/features/splash/presentation/splash_screen.dart';

import '../../features/Member_info/presentation/widget/member_info_screen.dart';
import '../../features/Project_Info/presentation/widget/project_add_directory/project_entry_screen.dart';


final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = GoRouterRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);
  //final refreshNotifier = AuthNotifierRefresh(ref);
  // final auth = ref.watch(authProvider);
  return GoRouter(
    initialLocation: Routes.splashScreen,
    refreshListenable: refreshNotifier,
    // refreshListenable: refreshNotifier,
    observers: [LoggingNavigatorObserver()],
    redirect: (context, state) {
      // final authState = ref.read(authStatusProvider);
      final authState = ref.read(newauthStatusProvider);
      final loc = state.matchedLocation;

      // if (authState == AuthStatus.loading) return null;
      if (authState == AuthStatus.loading) {
        return loc == Routes.splashScreen ? null : Routes.splashScreen;
      }
      // 2️⃣ Unauthenticated users
      if (authState == AuthStatus.unauthenticated) {
        return loc == Routes.loginScreen ? null : Routes.loginScreen;
      }

      // Unauthenticated → go to login/register
      // if (authState == AuthStatus.unauthenticated && loc != Routes.loginScreen ) {
      //   return Routes.loginScreen;
      // }

      // Authenticated → prevent access to guest pages
      if (authState == AuthStatus.authenticated && (loc == Routes.loginScreen ||  loc == Routes.splashScreen)) {
        return Routes.home;
      }

      // Otherwise → no redirect
      return null;


    },

   
    errorBuilder: (context, state) => LoginScreen(),
    routes: [
       GoRoute(name: Routes.splashScreen, path: Routes.splashScreen, builder: (context, state) => SplashScreeen()),
       GoRoute(name: Routes.loginScreen, path: Routes.loginScreen, builder: (context, state) => LoginScreen()),
      // GoRoute(name: Routes.registerScreen, path: Routes.registerScreen, builder: (context, state) => SchoolRegisterScreen()),
      // GoRoute(name: Routes.changePass, path: Routes.changePass, builder: (context, state) => ChangePasswordScreen()),
       GoRoute(name: Routes.home, path: Routes.home, builder: (context, state) => HomeScreen()),
      GoRoute(path: Routes.subMenu, name: Routes.subMenu, builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return SubmenuScreen(
          menuTitle: args?['menuName'] ?? '',
          headersubMenuIcon: args?['icon'] ?? '',
          subMenuColor: args?['color'] ?? '',
        );

      } ),
      GoRoute(path: Routes.memberInfo,name: Routes.memberInfo,builder: (context, state) => MemberInfoScreen(),),
       GoRoute(path: Routes.memberRegistration, name: Routes.memberRegistration, builder: (context, state) => MemberRegistrationFormScreen()),
      GoRoute(path: Routes.kistiInfo,name: Routes.kistiInfo,builder: (context, state) => KistiInfoScreen(),),
      GoRoute(path: Routes.project,name: Routes.project,builder: (context, state) => ProjectInfoScreen(),),
      GoRoute(path: Routes.projectEntry, name: Routes.projectEntry, builder: (context, state) => ProjectEntryScreen()),
      // GoRoute(path: Routes.allhomework, name: Routes.allhomework, builder: (context, state) => ViewAllHomeworkScreen()),
      // GoRoute(path: Routes.hwByuser, name: Routes.hwByuser, builder: (context, state) => MyHomeworkListScreen()),

      // GoRoute(path: Routes.hwMap, name: Routes.hwMap, builder: (context, state) => HomeworkMapScreen()),
      // GoRoute(path: Routes.notice, name: Routes.notice, builder: (context, state) => NoticeListScreen()),
    ],
  );
});
