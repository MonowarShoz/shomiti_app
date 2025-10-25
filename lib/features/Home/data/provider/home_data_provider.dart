import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/base_provider.dart';
import 'package:imsomitiapp/features/Home/data/datasource/local/home_local_data_src_impl.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/home_remote_data_source.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/home_remote_data_source_impl.dart';
import 'package:imsomitiapp/features/Home/data/repository/home_repo_impl.dart';
import 'package:imsomitiapp/features/Home/domain/Repository/home_repo.dart';
import 'package:imsomitiapp/features/Home/data/datasource/local/home_local_data_source.dart';

final homelocalDataSourceProvider = FutureProvider<HomeLocalDataSource>((
  ref,
) async {
  final prefs = await ref.read(sharedPrefHelperProvider.future);
  return HomeLocalDataSrcImpl(prefs: prefs);
});

final homeRemoteDataSrcProvider = FutureProvider<HomeRemoteDataSource>((
  ref,
) async {
  final apiService = await ref.read(apiServiceProvider.future);
  return HomeRemoteDataSourceImpl(apiService: apiService, ref: ref);
});

final homeDataRepositoryProvider = FutureProvider<HomeRepo>((ref) async {
  final localSrc = await ref.read(homelocalDataSourceProvider.future);
  final remoteSrc = await ref.read(homeRemoteDataSrcProvider.future);

  return HomeRepoImpl(localSrc,remoteSrc);
});
