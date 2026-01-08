import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imsomitiapp/core/base_widget/custom_date_picker.dart';
import 'package:imsomitiapp/core/base_widget/custom_input_field_suffix.dart';
import 'package:imsomitiapp/core/helper/date_converter.dart';
import 'package:imsomitiapp/features/Project_Info/presentation/provider/project_add_notifier.dart';
import 'package:imsomitiapp/features/Project_Info/presentation/provider/project_info_notifier.dart';
import 'package:imsomitiapp/features/Project_Info/presentation/widget/project_add_directory/project_add_datefield.dart';
import 'package:imsomitiapp/features/Project_Info/presentation/widget/project_add_directory/project_add_form_section.dart';

import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/routing/routes.dart';

class ProjectEntryScreen extends ConsumerStatefulWidget {
  const ProjectEntryScreen({super.key});

  @override
  ConsumerState createState() => _ProjectEntryScreenState();
}

class _ProjectEntryScreenState extends ConsumerState<ProjectEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _projectNameController = TextEditingController();
  final _projectLocationController = TextEditingController();
  final _budgetController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  validateSubmitProjectEntry(WidgetRef ref) {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(projectAddNotifierProvider.notifier)
          .addProject(
            projectName: _projectNameController.text,
            startDate: DateConverter.dateFormatStyle3(_startDate),
            budget: int.parse(_budgetController.text),
            fromDate: DateConverter.dateFormatStyle3(_endDate),
            location: _projectLocationController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectAddState = ref.watch(projectAddNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Add Project'),backgroundColor: Colors.white,foregroundColor: Colors.black,),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ProjectAddFormSection(
              icon: Icons.business_center,
              iconColor: Colors.blue,
              label: 'Project Name',
              child: CustomTextInputField(controller: _projectNameController, hintText: 'Enter project name', textInputType: TextInputType.text),
            ),
            const SizedBox(height: 20),
            ProjectAddFormSection(
              icon: Icons.location_on_outlined,
              iconColor: Colors.red,
              label: 'Project Location',
              child: CustomTextInputField(controller: _projectLocationController, hintText: 'Enter Location name', textInputType: TextInputType.text),
            ),
            const SizedBox(height: 20),
            ProjectAddFormSection(
              icon: Icons.account_balance_wallet_outlined,
              iconColor: Colors.green,
              label: 'Project Budget',
              child: CustomTextInputField(controller: _budgetController, hintText: 'Enter Budget', textInputType: TextInputType.number),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.calendar_today, color: Colors.blue[700], size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Project Timeline',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProjectAddDateField(
                    label: 'Start Date',
                    date: _startDate,
                    onTap: () async {
                      final date = await showCustomDatePicker(context: context);
                      if (date != null) {
                        setState(() {
                          _startDate = date;
                        });
                      }
                    },
                    formattedDate: _startDate == null ? "Select Date" : DateConverter.dateFormatStyle2(_startDate),
                  ),
                  ProjectAddDateField(
                    label: 'End Date',
                    date: _endDate,
                    onTap: () async {
                      final date = await showCustomDatePicker(context: context);
                      if (date != null) {
                        setState(() {
                          _endDate = date;
                        });
                      }
                    },
                    formattedDate: _endDate == null ? "Select Date" : DateConverter.dateFormatStyle2(_endDate),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: projectAddState.isLoading
                          ? null
                          : () {
                              validateSubmitProjectEntry(ref);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: projectAddState.isLoading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Text('Create Project', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  projectAddState.when(
                    data: (data) {
                      if (data != null && data.isNotEmpty) {
                        final isSuccess = !data.toLowerCase().contains('failed');
                        return Container(
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isSuccess ? Colors.green.shade50 : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isSuccess ? Colors.green.shade200 : Colors.red.shade200),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: isSuccess ? Colors.green.shade100 : Colors.red.shade100, shape: BoxShape.circle),
                                child: Icon(
                                  isSuccess ? Icons.check_circle : Icons.error,
                                  color: isSuccess ? Colors.green.shade700 : Colors.red.shade700,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                isSuccess ? 'Project Add Successful!' : 'Project Entry Failed',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: isSuccess ? Colors.green.shade700 : Colors.red.shade700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                data,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, color: isSuccess ? Colors.green.shade700 : Colors.red.shade700, height: 1.5),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isSuccess ? Colors.green.shade600 : Colors.red.shade600,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  onPressed: () {
                                    ref.invalidate(projectAddNotifierProvider);
                                    if (isSuccess) {
                                      ref.invalidate(projectInfoNotifierProvider);
                                      context.pushNamed(Routes.project);
                                      //context.go(Routes.loginScreen);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            children: [
                                              const Icon(Icons.error, color: Colors.white),
                                              const SizedBox(width: 8),
                                              Expanded(child: Text(data)),
                                            ],
                                          ),
                                          backgroundColor: Colors.red.shade600,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_forward),
                                  label: Text(
                                    isSuccess ? 'View in List' : 'Try Again',
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    loading: () => Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          const CircularProgressIndicator(color: Color(0xFF667EEA)),
                          const SizedBox(height: 12),
                          Text(
                            'Registering your Member...',
                            style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    error: (err, _) {
                      if (err is ApiErrorHandler) {
                        return Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red.shade700),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Error: ${err.apiErrorModel.message}',
                                  style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Text("Something went wrong");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
