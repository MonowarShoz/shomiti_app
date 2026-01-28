import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';

import '../../data/datasource/remote/Model/get_vendor_model.dart';
import '../../domain/provider/accounts_usecase_provider.dart';

class GetVendorNotifier extends AsyncNotifier<List<GetVendorModel>> {
  @override
  Future<List<GetVendorModel>> build() async => [];

  Future<void> load() async {
    state = const AsyncLoading();

    final useCase = await ref.read(getVendorDataUseCaseProvider.future);

    final result = await useCase();

    result.when(success: (data) => state = AsyncData(data ?? []), failure: (error) => state = AsyncError(error, StackTrace.current));
  }
}

final getVendorNotifierProvider = AsyncNotifierProvider<GetVendorNotifier, List<GetVendorModel>>(GetVendorNotifier.new);
