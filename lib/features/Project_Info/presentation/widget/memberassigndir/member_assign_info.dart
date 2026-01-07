import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_widget/empy_state_widget.dart';
import '../../../../../core/base_widget/error_state_widget.dart';
import '../../../../../core/helper/date_converter.dart';
import '../../../data/datasource/remote/model/get_member_assign_model.dart';
import '../../provider/member_assign_notifier.dart';
import '../info_row_widget.dart';
import 'member_assign_save.dart';

class MemberAssignInfoScreen extends ConsumerWidget {
  const MemberAssignInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberAssignInfoState = ref.watch(memberAssignNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'Assign History Info',
          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (shContext) => MemberAssignProjectScreen(sheetContext: shContext),
                );
              },
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.add, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
      body: memberAssignInfoState.when(
        data: (data) {
          if (data.isEmpty) {
            return const EmptyState(message: 'No records yet', icon: Icons.receipt_long_outlined);
          }
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final memberAssign = data[index];
              return _buildMemberAssignTile(memberAssign);
            },
          );
        },
        error: (error, stackTrace) {
          return ErrorState(message: error.toString(), onRetry: () => ref.invalidate(memberAssignNotifierProvider));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black));
        },
      ),
    );
  }

  Widget _buildMemberAssignTile(MemberAssigninfoModel memberAssignModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.business_center, color: Colors.blue[700], size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    memberAssignModel.projectname ?? 'Unnamed Project',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                InfoRow(icon: Icons.person, label: 'Member', value: memberAssignModel.givenName ?? "", iconColor: Colors.red),
                const SizedBox(height: 12),
                InfoRow(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Budget',
                  value: DateConverter.formatCurrency(memberAssignModel.amount ?? 0),
                  iconColor: Colors.green,
                ),
                const SizedBox(height: 12),
                InfoRow(
                  icon: Icons.person_outline,
                  label: 'Assigned By',
                  value: memberAssignModel.assignBy != null ? '${memberAssignModel.assignBy}' : 'Not Assigned',
                  iconColor: Colors.purple,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
