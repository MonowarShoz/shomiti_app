
import 'package:imsomitiapp/features/settings/data/local/settings_local_datasrc.dart';
import 'package:imsomitiapp/features/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository{
  final SettingsLocalDatasrc _localDataSource;
  SettingsRepositoryImpl(this._localDataSource);
  @override
  Future<void> logout() async {
    await _localDataSource.logOut();
  }
}