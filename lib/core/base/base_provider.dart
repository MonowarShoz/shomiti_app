import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:imsomitiapp/core/base/base_local_data_source.dart';
import 'package:imsomitiapp/core/base/remote_data_source.dart';
import 'package:imsomitiapp/core/helper/shared_pref_helper.dart';
import 'package:imsomitiapp/core/networking/api_service.dart';
import 'package:imsomitiapp/core/networking/dio_factory.dart';

import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) => FlutterSecureStorage(),);

final dioProvider = FutureProvider<Dio>((ref) async {
  return DioFactory.getDio();
});

final sharedPrefHelperProvider = FutureProvider<SharedPrefHelper>((ref) async {
  final pref = await ref.read(sharedPreferenceProvider.future);
  final secureStorage =  ref.read(secureStorageProvider);
  return SharedPrefHelper(pref,secureStorage);
});
final baseLocalDataSourceProvider = FutureProvider<BaseLocalDataSource>((
  ref,
) async {
  final baseLocal = await ref.read(sharedPrefHelperProvider.future);
  return BaseLocalDataSource(prefs: baseLocal);
});

final apiServiceProvider = FutureProvider<ApiService>((ref) async {
  final dio = await ref.read(dioProvider.future);
  return ApiService(dio);
});
final baseRemoteDataSourceProvider = FutureProvider<BaseRemoteDataSource>((
  ref,
) async {
  final apiService = await ref.read(apiServiceProvider.future);
  return BaseRemoteDataSource(apiService: apiService,ref: ref);
});
