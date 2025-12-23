import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/helper/extensions.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/presentation/provider/kistiInfo_notifier.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/presentation/provider/kisty_save_notifier.dart';

import '../../../../core/base_widget/app_custom_dialog.dart';
import '../../../Project_Info/presentation/provider/project_info_notifier.dart';
import '../provider/crtype_notifier.dart';

class KistiSaveScreen extends ConsumerStatefulWidget {
  final BuildContext sheetContext;
  const KistiSaveScreen( {super.key,required this.sheetContext,});

  @override
  ConsumerState createState() => _KistiSaveScreenState();
}

class _KistiSaveScreenState extends ConsumerState<KistiSaveScreen> {
  final _formKey = GlobalKey<FormState>();
  final typeNameController = TextEditingController();
  final amountController = TextEditingController();
  int? selectedCreditType;
  int? selectedProject;

  @override
  Widget build(BuildContext context) {
    final creditState = ref.watch(creditNotifierProvider);
    final projectState = ref.watch(projectInfoNotifierProvider);
    final kistiSavestate = ref.watch(kistiTypeSaveNotiferProvider);
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
                const Text(
                  'Add Kisti Type',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                ),
                const SizedBox(height: 24),
                _buildLabel('Type Name'),
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
                _buildLabel('Amount'),
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
                _buildLabel('Credit Type'),
                const SizedBox(height: 8),
                creditState.when(
                  data: (creditList) {
                    return DropdownButtonFormField<int>(
                      initialValue: selectedCreditType,
                      hint: Text(
                        'Select credit type',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
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
                    return dropdownErrorWidget(
                      errorTitle: 'Failed To load Credit',
                      callback: () {
                        ref.invalidate(creditNotifierProvider);
                      },
                    );
                  },
                  loading: () {
                    return dropdownLoadingWidget(loadingTitle: 'Loading Credit');
                  },
                ),
                const SizedBox(height: 20),

                // Project Type Dropdown
                _buildLabel('Project'),
                projectState.when(
                  data: (projectList) {
                    return DropdownButtonFormField<int>(
                      initialValue: selectedProject,
                      hint: Text(
                        'Select Project',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: projectList.map((project) => DropdownMenuItem(value: project.id, child: Text(project.projectName ?? ""))).toList(),
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
                    return dropdownErrorWidget(
                      errorTitle: 'Failed To load Project',
                      callback: () {
                        ref.invalidate(projectInfoNotifierProvider);
                      },
                    );
                  },
                  loading: () {
                    return dropdownLoadingWidget(loadingTitle: 'Loading Project...');
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:kistiSavestate.isLoading ? null : () async{
                      if (_formKey.currentState?.validate() ?? false) {
                        if(selectedProject != null && selectedCreditType != null){
                        await  ref
                              .read(kistiTypeSaveNotiferProvider.notifier)
                              .saveKistyType(
                            typeName: typeNameController.text,
                            amount: int.parse(amountController.text),
                            projectId: selectedProject!,
                            creditId: selectedCreditType!,
                          );
                        final result = ref.read(kistiTypeSaveNotiferProvider);
                        if(result.hasValue && result.value != null){

                          ref.invalidate(kistiInfoNotifierProvider);


                          if (context.mounted) {
                            AppSnackBar.show(context, message: 'Successfully Kisty Type added',backgroundColor: Colors.green);
                            context.pop();
                          }
                        }else{
                          if (context.mounted) {
                            AppSnackBar.show(context, message: 'Something went wrong',backgroundColor: Colors.red);
                            context.pop();
                          }
                        }

                        }else{
                          if (context.mounted) {
                            AppSnackBar.show(context, message: 'Something went wrong',backgroundColor: Colors.red);
                            context.pop();
                          }
                        }

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child:kistiSavestate.isLoading ? CircularProgressIndicator(): const Text('Add Kisti', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
    );
  }

  InputDecoration _decoration({String? errorText}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.all(16),
      errorText: errorText,
    );
  }

  Widget dropdownLoadingWidget({required String loadingTitle}) {
    return DropdownButtonFormField<int>(
      initialValue: null,
      decoration: _decoration(),
      items: const [],
      onChanged: null,
      // disabled
      hint: Row(
        children: [
          SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2)),
          SizedBox(width: 12),
          Text(loadingTitle),
        ],
      ),
    );
  }

  Widget dropdownErrorWidget({required String errorTitle, required VoidCallback callback}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<int>(
          value: null,
          decoration: _decoration(errorText: errorTitle),
          items: const [],
          onChanged: null,
          hint: const Text('Unable to load'),
        ),
        const SizedBox(height: 8),
        TextButton.icon(onPressed: callback, icon: const Icon(Icons.refresh), label: const Text('Retry')),
      ],
    );
  }
}
