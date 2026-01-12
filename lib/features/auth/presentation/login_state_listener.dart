import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base_widget/app_custom_dialog.dart';
import 'package:imsomitiapp/core/base_widget/error_dialog.dart';
import 'package:imsomitiapp/core/base_widget/loading_indicator.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_response_model.dart';
import 'package:imsomitiapp/features/auth/presentation/provider/login_notifier_provider.dart';

class SignInStateListener extends ConsumerWidget {
  const SignInStateListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<LoginResponseModel?>>(loginNotifierProvider, (previous, next) {
      if (next is AsyncLoading) {
        if (context.mounted) {
          LoadingOverlay.show(context);
        }
        return;
      }

      // 2️⃣ Always hide loading when not loading
      LoadingOverlay.hide();

      if (next is AsyncError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            ErrorDialog.show(context, next.error.toString());
          }
        });
        return;
      }
      if (previous is AsyncLoading && next is AsyncData<LoginResponseModel?>) {
        if (next.value != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              AppSnackBar.show(context, message: 'Login Successful',backgroundColor: Colors.green);
            }
          });
        }
      }
    });
    return const SizedBox.shrink();
  }
}
