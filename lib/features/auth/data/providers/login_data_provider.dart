
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/base_provider.dart';
import 'package:imsomitiapp/features/auth/data/data_source/local/login_local_data_source.dart';
import 'package:imsomitiapp/features/auth/data/data_source/local/login_local_data_source_impl.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/login_remote_dt_src.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/login_remote_dt_src_impl.dart';
import 'package:imsomitiapp/features/auth/data/repository/login_repository_implementation.dart';
import 'package:imsomitiapp/features/auth/domain/repository/login_repository.dart';

final loginLocalDataSourceProvider = FutureProvider<LoginLocalDataSource>((
  ref,
) async {
  final prefs = await ref.read(sharedPrefHelperProvider.future);
  
  return LoginLocalDataSourceImpl(prefs: prefs, );
});

final loginRemoteDataSourceProvider = FutureProvider<LoginRemoteDataSource>((
  ref,
) async {
  final apiService = await ref.read(apiServiceProvider.future);
  return LoginRemoteDtSrcImpl(apiService: apiService,ref: ref);
});

final loginRepositoryProvider = FutureProvider<LoginRepository>((ref) async {
  final localDataSource = await ref.read(loginLocalDataSourceProvider.future);
  final remoteDataSource = await ref.read(loginRemoteDataSourceProvider.future);

  return LoginRepositoryImplementation(localDataSource, remoteDataSource);
});
