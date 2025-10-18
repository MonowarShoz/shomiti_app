import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/base_provider.dart';
import 'package:imsomitiapp/features/settings/data/local/settings_local_datasrc.dart';
import 'package:imsomitiapp/features/settings/data/local/settings_local_datasrc_impl.dart';
import 'package:imsomitiapp/features/settings/data/repository/settings_repository_impl.dart';
import 'package:imsomitiapp/features/settings/domain/repository/settings_repository.dart';


final settingLocalDataProvider = FutureProvider<SettingsLocalDatasrc>((
  ref,
) async {
  final prfs = await ref.read(sharedPrefHelperProvider.future);
  return SettingsLocalDatasrcImpl(prefs: prfs);
});

final settingRepositoryProvider = FutureProvider<SettingsRepository>((ref) async{
  final local = await ref.read(settingLocalDataProvider.future);
  return SettingsRepositoryImpl(local);
  
},);