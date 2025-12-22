import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/base_provider.dart';
import 'package:imsomitiapp/features/Home/data/provider/home_data_provider.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/kisty_remote_src_impl.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/kisty_subs_remote_src.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/repository/kisty_remote_repo_impl.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/domain/repository/kisty_repository.dart';

final kistyRemoteSrcProvider = FutureProvider<KistyRemoteSrc>((ref) async{
  final apiService = await ref.read(apiServiceProvider.future);
  return KistyRemoteSrcImpl(apiService: apiService, ref: ref);
},);

final kistyRepoProvider = FutureProvider<KistyRepository>((ref) async{
  final homeLocalService = await ref.read(homelocalDataSourceProvider.future);
  final kistyRemoteDataSrc = await ref.read(kistyRemoteSrcProvider.future);
  return KistyRepoImpl(localDataSource: homeLocalService,kistyRemoteSrc: kistyRemoteDataSrc);

},);