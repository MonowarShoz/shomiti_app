import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/helper/date_converter.dart';
import 'package:imsomitiapp/core/helper/extensions.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/presentation/provider/project_info_notifier.dart';

import '../../../../../core/base_widget/error_state_widget.dart';
import '../../../../../core/routing/routes.dart';
import '../info_row_widget.dart';

class ProjectInfoScreen extends ConsumerWidget {
  const ProjectInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectInfoState = ref.watch(projectInfoNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Projects',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),

            child: IconButton(
              icon:  Container(
                  width: 40,
                  height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: Icon(Icons.add, color: Colors.white)),
              onPressed: () {
                context.pushNamed(Routes.projectEntry);
              },
            ),
          ),
        ],
      ),
      body: projectInfoState.when(
        data: (projectList) {
          if (projectList.isEmpty) {
            return const Center(
              child: Text('No projects available', style: TextStyle(color: Colors.black54)),
            );
          } else {
            return ListView.builder(
              itemCount: projectList.length,
              itemBuilder: (context, index) {
                final project = projectList[index];
                return ProjectCard(project: project);
              },
            );
          }
        },
        error: (error, stackTrace) {
          return ErrorState(message: error.toString(), onRetry: () => ref.invalidate(projectInfoNotifierProvider));
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final GetProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final pduration = DateConverter.calculateDuration(
      startDate: project.startDate!.toIso8601String(),
      endDate: project.tentitiveEndDate!.toIso8601String(),
    );
    final durationMonths = (pduration / 30).round();
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
                    project.projectName ?? 'Unnamed Project',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Active',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green[700]),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                InfoRow(icon: Icons.location_on_outlined, label: 'Location', value: project.proLocation ?? "", iconColor: Colors.red),
                const SizedBox(height: 12),
                InfoRow(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Budget',
                  value: DateConverter.formatCurrency(project.budget ?? 0),
                  iconColor: Colors.green,
                ),
                const SizedBox(height: 12),
                InfoRow(
                  icon: Icons.person_outline,
                  label: 'Director',
                  value: project.givenName != null ? '${project.givenName} ${project.sureName ?? ''}' : 'Not Assigned',
                  iconColor: Colors.purple,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: Colors.blue[700]),
                          const SizedBox(width: 8),
                          const Text(
                            'Project Timeline',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              '$durationMonths months',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue[700]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Start Date', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                const SizedBox(height: 4),
                                Text(
                                  DateConverter.dateFormatStyle2(project.startDate),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward, size: 20, color: Colors.grey[400]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'End Date',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateConverter.dateFormatStyle2(project.tentitiveEndDate),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),

                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


