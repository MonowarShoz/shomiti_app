import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base_widget/error_dialog.dart';
import 'package:imsomitiapp/core/base_widget/loading_indicator.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_response_model.dart';
import 'package:imsomitiapp/features/auth/presentation/provider/login_notifier_provider.dart';


class SignInStateListener extends ConsumerWidget {
  const SignInStateListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<LoginResponseModel?>>(loginNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            LoadingOverlay.hide();
            
          }
        },
        loading: () {
          
          if(context.mounted){
            LoadingOverlay.show(context);
          }
          
       
        },
        error: (error, stackTrace) {
          LoadingOverlay.hide();
         

          // Handle error, e.g., show a snackbar with the error message
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              ErrorDialog.show(context, error.toString());
            }
          });
        },
      );
    });
    return const SizedBox.shrink();
  }
}
