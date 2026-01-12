import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/base_widget/common_form_widget.dart';
import 'package:imsomitiapp/core/helper/extensions.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/presentation/provider/kistiInfo_notifier.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/presentation/provider/kisty_save_notifier.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/presentation/provider/subscription_type_notifier.dart';

import '../../../../core/base_widget/app_custom_dialog.dart';
import '../../../Project_Info/presentation/provider/project_info_notifier.dart';
import '../../data/datasource/Model/KistyTypeInfo.dart';
import '../../data/datasource/Model/get_subscription_type_model.dart';
import '../provider/add_subscription_type_notifier.dart';
import '../provider/crtype_notifier.dart';

class SubscriptionTypeEntryScreen extends ConsumerStatefulWidget {
  final GetSubscriptionTypeModel? editData;
  final BuildContext sheetContext;
  final bool isEditMode;

  const SubscriptionTypeEntryScreen({super.key, required this.sheetContext, this.editData, required this.isEditMode});

  @override
  ConsumerState createState() => _SubscriptionTypeEntryScreenState();
}

class _SubscriptionTypeEntryScreenState extends ConsumerState<SubscriptionTypeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final typeNameController = TextEditingController();
  final amountController = TextEditingController();
  int? selectedCreditType;
  int? selectedProject;
  int? id;

  @override
  void initState() {
    super.initState();
    if (widget.editData != null) {
      id = widget.editData!.id;
      selectedCreditType = widget.editData!.crid;
      selectedProject = widget.editData!.projectId;
      typeNameController.text = widget.editData!.typeName!;
      amountController.text = widget.editData!.amount.toString();
    } else {
      amountController.clear();
      id = 0;
      selectedProject = null;
      selectedCreditType = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final creditState = ref.watch(creditNotifierProvider);
    final projectState = ref.watch(projectInfoNotifierProvider);
    final subscriptionTypeAddState = ref.watch(subscriptionTypeSaveNotifierProvider);
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                const SizedBox(height: 24),
                widget.isEditMode ? const Text(
                  'Edit Subscription Type',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                ) :  const Text(
                  'Add Subscription Type',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                ),
                const SizedBox(height: 24),
                FormWidgets.buildLabel('Type Name'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: typeNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter type name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter type name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Amount Field
                FormWidgets.buildLabel('Amount'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter amount',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixText: '৳ ',
                    prefixStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter valid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                FormWidgets.buildLabel('Credit Type'),
                const SizedBox(height: 8),
                creditState.when(
                  data: (creditList) {
                    final validInitialValue = creditList.any(
                          (p) => p.id == selectedCreditType,
                    )
                        ? selectedCreditType
                        : null;
                    return DropdownButtonFormField<int>(
                      initialValue: validInitialValue,
                      hint: Text('Select credit type', style: TextStyle(color: Colors.grey[400])),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: creditList.map((credit) => DropdownMenuItem(value: credit.id, child: Text(credit.crname ?? ""))).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCreditType = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select credit type';
                        }
                        return null;
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    return FormWidgets.dropdownErrorWidget(
                      errorTitle: 'Failed To load Credit',
                      callback: () {
                        ref.invalidate(creditNotifierProvider);
                      },
                    );
                  },
                  loading: () {
                    return FormWidgets.dropdownLoadingWidget(loadingTitle: 'Loading Credit');
                  },
                ),
                const SizedBox(height: 20),

                // Project Type Dropdown
                FormWidgets.buildLabel('Project'),
                projectState.when(
                  data: (projectList) {
                    final validInitialValue = projectList.any(
                          (p) => p.projectId == selectedProject,
                    )
                        ? selectedProject
                        : null;
                    return DropdownButtonFormField<int>(
                      initialValue: validInitialValue,
                      hint: Text('Select Project', style: TextStyle(color: Colors.grey[400])),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: projectList.map((project) => DropdownMenuItem(value: project.projectId, child: Text(project.projectName ?? ""))).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProject = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Project type';
                        }
                        return null;
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    return FormWidgets.dropdownErrorWidget(
                      errorTitle: 'Failed To load Project',
                      callback: () {
                        ref.invalidate(projectInfoNotifierProvider);
                      },
                    );
                  },
                  loading: () {
                    return FormWidgets.dropdownLoadingWidget(loadingTitle: 'Loading Project...');
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: subscriptionTypeAddState.isLoading
                        ? null
                        : () async {
                      await submitAddEditSubscriptionType(ref);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: subscriptionTypeAddState.isLoading
                        ? CircularProgressIndicator()
                        : widget.isEditMode
                        ? const Text('Edit Subscription Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                        : const Text('Add Subscription Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitAddEditSubscriptionType(WidgetRef ref) async {
    if (_formKey.currentState?.validate() ?? false) {
      if (selectedProject != null && selectedCreditType != null) {
        if (widget.isEditMode) {
          await ref
              .read(subscriptionTypeSaveNotifierProvider.notifier)
              .saveSubscriptionType(
            id: id!,
            typeName: typeNameController.text,
            amount: int.parse(amountController.text),
            projectId: selectedProject!,
            creditId: selectedCreditType!,
          );
          final result = ref.read(subscriptionTypeSaveNotifierProvider);
          if (result.hasValue && result.value != null) {
            ref.invalidate(subscriptionTypeNotifierProvider);

            if (mounted) {
              AppSnackBar.show(context, message: 'Successfully Subscription Type Edited', backgroundColor: Colors.green);
              context.pop();
            }
          } else {
            if (mounted) {
              AppSnackBar.show(context, message: 'Something went wrong', backgroundColor: Colors.red);
              context.pop();
            }
          }
        } else {
          await ref
              .read(subscriptionTypeSaveNotifierProvider.notifier)
              .saveSubscriptionType(
            id: 0,
            typeName: typeNameController.text,
            amount: int.parse(amountController.text),
            projectId: selectedProject!,
            creditId: selectedCreditType!,
          );
          final result = ref.read(subscriptionTypeSaveNotifierProvider);
          if (result.hasValue && result.value != null) {
            ref.invalidate(subscriptionTypeNotifierProvider);

            if (mounted) {
              AppSnackBar.show(context, message: 'Successfully Subscription Type added', backgroundColor: Colors.green);
              context.pop();
            }
          } else {
            if (mounted) {
              AppSnackBar.show(context, message: 'Something went wrong', backgroundColor: Colors.red);
              context.pop();
            }
          }
        }
      } else {
        if (context.mounted) {
          AppSnackBar.show(context, message: 'Please select project ID and credit Type went wrong', backgroundColor: Colors.red);
          context.pop();
        }
      }
    }
  }
}
