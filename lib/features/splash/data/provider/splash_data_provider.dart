import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/base_provider.dart';
import 'package:imsomitiapp/features/splash/data/datasource/local/splash_local_data_source.dart';
import 'package:imsomitiapp/features/splash/data/datasource/local/splash_local_data_source_impl.dart';
import 'package:imsomitiapp/features/splash/data/repository/splash_repository_implementation.dart';
import 'package:imsomitiapp/features/splash/domain/repository/splash_repository.dart';

final splashLocalDataSourceProvider = FutureProvider<SplashLocalDataSource>((
  ref,
) async {
  final prefs = await ref.read(sharedPrefHelperProvider.future);
  return SplashLocalDataSourceImpl(prefs: prefs);
});
final splashRepositoryProvider = FutureProvider<SplashRepository>((ref) async {
  final dataSource = await ref.watch(splashLocalDataSourceProvider.future);
  return SplashRepositoryImplementation(dataSource);
});