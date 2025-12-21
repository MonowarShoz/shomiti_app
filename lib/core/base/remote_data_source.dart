import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_error_handler.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/core/networking/api_service.dart';
import 'package:imsomitiapp/features/auth/presentation/provider/login_notifier_provider.dart';


class BaseRemoteDataSource {
  final ApiService apiService;
   final Ref ref;
   
  BaseRemoteDataSource( {required this.apiService,required this.ref,});

  Future<ApiResult<T>> safeApiCall<T>(Future<T> Function() apiCall, {bool requiresAuth = true}) async {
    try{
      final result = await apiCall();
      if(requiresAuth){
        //ref.read(authProvider.notifier).state = true;
      }
        
      return ApiResult.success(result);
    } catch (error)
    {
      if(error is DioException && error.response?.statusCode == 401){
        await ref.read(newauthStatusProvider.notifier).seUntAuthenticated();
        // ref.read(authStatusProvider.notifier).state =
        //       AuthStatus.unauthenticated;
        //  ref.read(authProvider.notifier).state = false;
      }
      debugPrint("❌ safeApiCall error: $error");
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}