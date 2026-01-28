import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/base_provider.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/accounts_remote_dt_source.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/accounts_remote_dt_src_impl.dart';
import 'package:imsomitiapp/features/Accounts/domain/repository/accounts_repository.dart';
import 'package:imsomitiapp/features/Home/data/provider/home_data_provider.dart';

import '../repository/accounts_repository_impl.dart';

final accountsRemoteSrcProvider = FutureProvider<AccountsRemoteDataSource>((ref) async{
  final apiService = await ref.read(apiServiceProvider.future);
  return AccountsRemoteDtSourceImpl(ref: ref, apiService: apiService);


},);

final accountsRepositoryProvider = FutureProvider<AccountsRepository>((ref) async{
  final localDataSource = await ref.read(homelocalDataSourceProvider.future);
  final remoteDateSrc = await ref.read(accountsRemoteSrcProvider.future);
  return AccountRepositoryImpl(localDataSource: localDataSource,accountsRemoteDataSource: remoteDateSrc);


},);