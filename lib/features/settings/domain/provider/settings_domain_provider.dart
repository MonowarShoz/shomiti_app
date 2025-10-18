
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/features/settings/data/provider/settings_data_provider.dart';
import 'package:imsomitiapp/features/settings/domain/usecases/settings_use_case.dart';

final settingUseCaseProvider = FutureProvider<SettingsUseCase>(
  (ref) async{
    final settRepository = await ref.read(settingRepositoryProvider.future);
    return SettingsUseCase(settRepository);
    
  },
);