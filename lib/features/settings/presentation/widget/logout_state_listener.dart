// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:school_notebook/core/base_widget/loading_indicator.dart';
// import 'package:school_notebook/core/helper/extensions.dart';
// import 'package:school_notebook/core/routing/routes.dart';
// import 'package:school_notebook/features/home/presentation/provider/home_menu_notifier_provider.dart';
// import 'package:school_notebook/features/settings/presentation/provider/setting_notifier.dart';


// class LogoutStateListener extends ConsumerWidget {
//   const LogoutStateListener({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.listen<AsyncValue<bool>>(logOutNotifierProvider, (previous, next) {
//       if (previous == next) return;
//       next.when(
//         data: (data) {
//           LoadingIndicator.hide(context);
//           if (data) 
//           {
          
//            WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (context.mounted) {
//             context.goNamed(Routes.loginScreen);
//           }
//         });
//           }
//         },
//         error: (error, stackTrace) {
//           LoadingIndicator.hide(context);
//         },
//         loading: () {
//           LoadingIndicator.show(context);
//         },
//       );
//     });

//     return const SizedBox.shrink();
//   }
// }
