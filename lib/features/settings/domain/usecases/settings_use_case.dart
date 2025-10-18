
import 'package:imsomitiapp/features/settings/domain/repository/settings_repository.dart' show SettingsRepository;

class SettingsUseCase {
  final SettingsRepository _settingsRepository;
  SettingsUseCase(this._settingsRepository);

  Future<void> call()async {
    await _settingsRepository.logout();
  } 
}