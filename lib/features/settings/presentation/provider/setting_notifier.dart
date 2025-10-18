import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:imsomitiapp/features/settings/domain/provider/settings_domain_provider.dart';
import 'package:imsomitiapp/features/settings/domain/usecases/settings_use_case.dart';


class SettingNotifier extends AsyncNotifier<bool> {
  late  SettingsUseCase _settingsUseCase;
  @override
  FutureOr<bool> build() async{
    _settingsUseCase = await ref.read(settingUseCaseProvider.future);
    return false;
    
  }

  Future<void> logOut() async {
    state = const AsyncLoading();
    try{
      await _settingsUseCase.call();
      //ref.invalidate(homeMenuNotifierProvider);
     
      state = AsyncValue.data(true);

    }catch (e,s){
      state = AsyncValue.error(e, s);

    }
  }
}

final logOutNotifierProvider= AsyncNotifierProvider<SettingNotifier,bool>(
  () => SettingNotifier(),

);