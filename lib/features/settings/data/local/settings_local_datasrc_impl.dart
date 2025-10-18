

import 'package:imsomitiapp/core/base/base_local_data_source.dart';
import 'package:imsomitiapp/features/settings/data/local/settings_local_datasrc.dart';

class SettingsLocalDatasrcImpl extends BaseLocalDataSource implements SettingsLocalDatasrc{
  SettingsLocalDatasrcImpl({super.prefs});

  @override
  Future<void> logOut() async {
    await logoutAndClearCache();
    }
}