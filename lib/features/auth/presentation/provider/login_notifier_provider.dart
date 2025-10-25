import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/base_local_data_source.dart';
import 'package:imsomitiapp/core/base/base_provider.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/core/utils/app_strings.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_response_model.dart';
import 'package:imsomitiapp/features/auth/domain/entities/user.dart';
import 'package:imsomitiapp/features/auth/domain/providers/login_use_case_provider.dart';
import 'package:imsomitiapp/features/auth/domain/usecase/login_use_case.dart';

import 'package:imsomitiapp/features/settings/presentation/provider/setting_notifier.dart';

class LoginNotifier extends AsyncNotifier<LoginResponse?> {
  late final LoginUseCase _loginUseCase;

  @override
  FutureOr<LoginResponse?> build() async {
    _loginUseCase = await ref.read(loginUseCaseProvider.future);
    return null;
  }

  Future<void> login({required String username, required String password}) async {
    state = AsyncValue.loading();

    final result = await _loginUseCase.call(username: username, password: password, );
    result.when(
      success: (user) async {
        // ref.read(authStatusProvider.notifier).state = AuthStatus.authenticated;
        await ref.read(newauthStatusProvider.notifier).setAuthenticated(user.token ?? '');
        // ref.invalidate(homeMenuNotifierProvider);
        // await ref.read(homeMenuNotifierProvider.future);

        state = AsyncValue.data(user);
      },
      failure: (errorHandler) {
        print('login error message ${errorHandler.apiErrorModel.message}');
        state = AsyncValue.error(errorHandler.apiErrorModel.message ?? AppStrings.unexpectedError, StackTrace.current);
      },
    );
  }
}

final loginNotifierProvider = AsyncNotifierProvider<LoginNotifier, LoginResponse?>(() {
  return LoginNotifier();
});




final authProvider = StateProvider<bool?>((ref) => true);

enum AuthState { loggedIn, loggedOut }

final authStateProvider = Provider<AuthState>((ref) {
  final logoutState = ref.watch(logOutNotifierProvider);

  // If logout succeeded → user is logged out
  if (logoutState.value == true) {
    return AuthState.loggedOut;
  }

  // TODO: optionally check saved token here for real auth
  return AuthState.loggedIn;
});

enum AuthStatus { loading, authenticated, unauthenticated }

final authStatusProvider = StateProvider<AuthStatus>((ref) {
  return AuthStatus.loading;
});

class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier(Ref ref) {
    // React to any auth status changes
    ref.listen<AuthStatus>(newauthStatusProvider, (previous, next) {
      notifyListeners();
    });
  }
}

//new
class AuthStatusNotifier extends StateNotifier<AuthStatus> {
  final Ref ref;
  AuthStatusNotifier(this.ref) : super(AuthStatus.loading) {
    _loadAuthStatus();
  }

  Future<void> _loadAuthStatus() async {
    final localDataSrc = await ref.read(baseLocalDataSourceProvider.future);
    final token = await localDataSrc.getAuthToken();
    if (token != null && token.isNotEmpty) {
      // Optional: verify token validity with API
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> setAuthenticated(String token) async {
     final baseLocalDataSource = await ref.read(baseLocalDataSourceProvider.future);
    await baseLocalDataSource.storeToken(token);
    state = AuthStatus.authenticated;
  }
  Future<void> seUntAuthenticated() async {
     final baseLocalDataSource = await ref.read(baseLocalDataSourceProvider.future);
    await baseLocalDataSource.storeToken('');
    state = AuthStatus.unauthenticated;
  }
}
//new
final newauthStatusProvider = StateNotifierProvider<AuthStatusNotifier,AuthStatus>((ref) {
  return AuthStatusNotifier(ref);
},);
