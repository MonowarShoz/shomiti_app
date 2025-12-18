import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_all_model.dart';
import 'package:imsomitiapp/features/Member_info/presentation/provider/member_data_notifier.dart';

final memberSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredMemberProvider = Provider<List<MemberInfoAllModel>>((ref) {

  final memberSearchQuery = ref.watch(memberSearchQueryProvider).trim();
  final allMemberList = ref.watch(memberDataNotifierProvider).value ?? [];
  final query = memberSearchQuery.toLowerCase();

  if (query.isEmpty) return allMemberList;

  return allMemberList.where((element) {
    final sureName = (element.sureName ?? '').toLowerCase();
    final givenName = (element.givenName ?? '').toLowerCase();
    return sureName.contains(query) || givenName.contains(query);
  }).toList();

});
