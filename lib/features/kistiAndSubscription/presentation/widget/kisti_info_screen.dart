import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/presentation/provider/kistiInfo_notifier.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/presentation/widget/kisti_save_screen.dart';

import '../../../../core/base_widget/empy_state_widget.dart';
import '../../../../core/base_widget/error_state_widget.dart';
import '../../data/datasource/Model/KistyTypeInfo.dart';

class KistiInfoScreen extends ConsumerWidget {
  const KistiInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kistiState = ref.watch(kistiInfoNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'Kisti Type Info',
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
                  builder: (shContext) => KistiSaveScreen(sheetContext: shContext,isEditMode: false,),
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
      body: kistiState.when(
        data: (data) {
          if (data.isEmpty) {
            return const EmptyState(message: 'No records yet', icon: Icons.receipt_long_outlined);
          }
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final kisti = data[index];
              return _buildKistiItem(kisti,context);
            },
          );
        },
        error: (error, stackTrace) {
          return ErrorState(message: error.toString(), onRetry: () => ref.invalidate(kistiInfoNotifierProvider));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black));
        },
      ),
    );
  }

  Widget _buildKistiItem(KistyTypeInfo kisti, BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with title and edit button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  kisti.typeName ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: ctx,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (shContext) => KistiSaveScreen(
                      sheetContext: shContext,
                      editData: kisti,
                      isEditMode: true,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 18,
                    color: Colors.green[700],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Amount and transaction type row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '৳${kisti.amount?.toStringAsFixed(0) ?? '0'}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kisti.crname == 'Debit'
                        ? Colors.red[50]
                        : Colors.green[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    kisti.crname ?? 'N/A',
                    style: TextStyle(
                      fontSize: 12,
                      color: kisti.crname == 'Debit'
                          ? Colors.red[600]
                          : Colors.green[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Project name
          if (kisti.projectname != null && kisti.projectname!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.folder_outlined, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      kisti.projectname!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Date
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[400]),
              const SizedBox(width: 6),
              Text(
                kisti.createdate ?? 'N/A',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
