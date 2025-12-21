import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/helper/extensions.dart';
import 'package:imsomitiapp/core/networking/api_error_handler.dart';
import 'package:imsomitiapp/features/Member_info/presentation/provider/member_filter_notifier.dart';
import 'package:imsomitiapp/features/Member_info/presentation/widget/member_details_widget.dart';

import '../../../../core/base_widget/custom_input_field_suffix.dart';
import '../../../../core/routing/routes.dart';
import '../provider/member_data_notifier.dart';

class MemberInfoScreen extends ConsumerStatefulWidget {
  const MemberInfoScreen({super.key});

  @override
  ConsumerState createState() => _MemberInfoScreenState();
}

class _MemberInfoScreenState extends ConsumerState<MemberInfoScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(memberSearchQueryProvider);
    final memberInfoState = ref.watch(memberDataNotifierProvider);
    final filteredList = ref.watch(filteredMemberProvider);
    return Scaffold(
      body: CustomScrollView(
        //shrinkWrap: true,
        slivers: [
          SliverAppBar(
            title: const Text('Members List', style: TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
            centerTitle: false,
            pinned: true,
            floating: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    context.pushNamed(Routes.memberRegistration);
                  },
                  icon: const Icon(Icons.person_add),
                  style: IconButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextInputField(
                controller: searchController,
                textInputType: TextInputType.text,
                hintText: 'Search Members',
                onChanged: (v) {
                  ref.read(memberSearchQueryProvider.notifier).state = v ?? '';
                },

                //setState(() => searchQuery = value),

                // decoration: InputDecoration(
                //   hintText: 'Search members...',
                //   hintStyle: TextStyle(color: Colors.grey[400]),
                //   prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                //   filled: true,
                //   fillColor: Colors.white,
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(12),
                //     borderSide: BorderSide(color: Colors.grey[200]!),
                //   ),
                //   enabledBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(12),
                //     borderSide: BorderSide(color: Colors.grey[200]!),
                //   ),
                //   focusedBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(12),
                //     borderSide: const BorderSide(color: Colors.teal, width: 1.5),
                //   ),
                //   contentPadding: const EdgeInsets.symmetric(vertical: 12),
                // ),
              ),
            ),
          ),
          memberInfoState.when(
            data: (memberInfoList) {
              if (memberInfoList.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_search, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text('No members found', style: TextStyle(fontSize: 16, color: Colors.grey[500])),
                      ],
                    ),
                  ),
                );
              } else {
                if (filteredList.isEmpty) {
                  return SliverFillRemaining(
                    child: _buildEmptyState(icon: Icons.search_off, title: 'No Results Found', message: 'Try different search terms'),
                  );
                } else {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final member = filteredList[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: InkWell(
                            onTap: () {

                                showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel: 'Close',
                                  transitionDuration: const Duration(milliseconds: 300),
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return MemberDetailDialog(memberData: member);
                                  },
                                  transitionBuilder: (context, animation, secondaryAnimation, child) {
                                    return ScaleTransition(
                                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeInCubic)),
                                      child: FadeTransition(opacity: animation, child: child),
                                    );
                                  },
                                );

                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  // Avatar
                                  // CircleAvatar(
                                  //   radius: 28,
                                  //   backgroundColor: Colors.green.withOpacity(0.1),
                                  //   child: Text(
                                  //     '',
                                  //     style: TextStyle(
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.w600,
                                  //       color: _getGenderColor(member['gender']),
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(width: 16),

                                  // Member Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                member.givenName ?? '',
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            // Container(
                                            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            //   decoration: BoxDecoration(
                                            //     color: Colors.grey[100],
                                            //     borderRadius: BorderRadius.circular(6),
                                            //   ),
                                            //   child: Text(
                                            //     '${member.memNo ?? 0}',
                                            //     style: TextStyle(
                                            //       fontSize: 12,
                                            //       fontWeight: FontWeight.w600,
                                            //       color: Colors.grey[700],
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),

                                        const SizedBox(height: 6),

                                        Row(
                                          children: [
                                            Icon(Icons.phone, size: 14, color: Colors.grey[500]),
                                            const SizedBox(width: 6),
                                            Text(member.phone ?? '', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                                          ],
                                        ),

                                        const SizedBox(height: 4),

                                        Row(
                                          children: [
                                            Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: Text(
                                                member.address ?? '',
                                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Arrow Icon
                                  Icon(Icons.chevron_right, color: Colors.grey[400]),
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: filteredList.length),
                    ),
                  );
                }
              }
            },
            error: (error, stackTrace) {
              if (error is ApiErrorHandler) {
                return SliverFillRemaining(child: _buildErrorState(error.apiErrorModel.message ?? ""));
              } else {
                return SliverFillRemaining(child: Text('Something went wrong'));
              }
            },
            loading: () {
              return SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String title, required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
            child: Icon(icon, size: 48, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 8),
          Text(message, style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text(
            'Error Loading Member',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red.shade700),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
