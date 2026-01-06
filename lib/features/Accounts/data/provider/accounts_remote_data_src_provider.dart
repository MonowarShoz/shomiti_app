import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/base_provider.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/accounts_remote_dt_source.dart';
import 'package:imsomitiapp/features/Accounts/data/datasource/remote/accounts_remote_dt_src_impl.dart';

final accountsRemoteSrcProvider = FutureProvider<AccountsRemoteDataSource>((ref) async{
  final apiService = await ref.read(apiServiceProvider.future);
  return AccountsRemoteDtSourceImpl(ref: ref, apiService: apiService);


},);