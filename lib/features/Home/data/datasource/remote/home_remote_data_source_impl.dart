import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/remote_data_source.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/home_remote_data_source.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';


class HomeRemoteDataSourceImpl extends BaseRemoteDataSource
    implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required super.apiService, required super.ref});

  @override
  Future<ApiResult<List<MenuModel>?>> getUserMenu(String token, String roleName) {
    return safeApiCall(() async {
      return await apiService?.getUserMenu(token, roleName);
    });
  }

  
}
