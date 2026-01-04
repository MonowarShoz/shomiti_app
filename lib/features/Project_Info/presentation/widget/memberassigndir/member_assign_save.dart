import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_widget/common_form_widget.dart';
import '../../../../Member_info/presentation/provider/member_data_notifier.dart';
import '../../provider/project_info_notifier.dart';

class MemberAssignProjectScreen extends ConsumerStatefulWidget {
  final BuildContext sheetContext;
  const MemberAssignProjectScreen( {super.key,required this.sheetContext,});

  @override
  ConsumerState createState() => _MemberAssignProjectScreenState();
}

class _MemberAssignProjectScreenState extends ConsumerState<MemberAssignProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  int? selectedCreditType;
  int? selectedProject;

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(projectInfoNotifierProvider);
    final memberListState = ref.watch(memberDataNotifierProvider);


    //final memberAssignSaveState = ref.watch(kistiTypeSaveNotiferProvider);
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
                  'Assign Member to Project',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                ),
                const SizedBox(height: 24),
                FormWidgets.buildLabel('Enter Payable Amount'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    hintText: 'Enter amount',
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


                FormWidgets.buildLabel('Project Type'),
                const SizedBox(height: 8),
                projectState.when(
                  data: (projectList) {
                    return DropdownButtonFormField<int>(
                      initialValue: selectedCreditType,
                      hint: Text(
                        'Select Project type',
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
                          selectedCreditType = value;
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
                      errorTitle: 'Failed To load Project Type',
                      callback: () {
                        //ref.invalidate(creditNotifierProvider);
                      },
                    );
                  },
                  loading: () {
                    return FormWidgets.dropdownLoadingWidget(loadingTitle: 'Loading Projects Type list');
                  },
                ),
                const SizedBox(height: 20),

                // Project Type Dropdown
                FormWidgets.buildLabel('Select Member'),
                memberListState.when(
                  data: (memberList) {
                    return DropdownButtonFormField<int>(
                      initialValue: selectedProject,
                      hint: Text(
                        'Select Member',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: memberList.map((member) => DropdownMenuItem(value: member.memNo, child: Text(member.givenName ?? ""))).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProject = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Member';
                        }
                        return null;
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    return FormWidgets.dropdownErrorWidget(
                      errorTitle: 'Failed To load Member',
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
                    onPressed: () async{
                      // if (_formKey.currentState?.validate() ?? false) {
                      //   if(selectedProject != null && selectedCreditType != null){
                      //     await  ref
                      //         .read(kistiTypeSaveNotiferProvider.notifier)
                      //         .saveKistyType(
                      //       typeName: typeNameController.text,
                      //       amount: int.parse(amountController.text),
                      //       projectId: selectedProject!,
                      //       creditId: selectedCreditType!,
                      //     );
                      //     final result = ref.read(kistiTypeSaveNotiferProvider);
                      //     if(result.hasValue && result.value != null){
                      //
                      //       ref.invalidate(kistiInfoNotifierProvider);
                      //
                      //
                      //       if (context.mounted) {
                      //         AppSnackBar.show(context, message: 'Successfully Kisty Type added',backgroundColor: Colors.green);
                      //         context.pop();
                      //       }
                      //     }else{
                      //       if (context.mounted) {
                      //         AppSnackBar.show(context, message: 'Something went wrong',backgroundColor: Colors.red);
                      //         context.pop();
                      //       }
                      //     }
                      //
                      //   }else{
                      //     if (context.mounted) {
                      //       AppSnackBar.show(context, message: 'Something went wrong',backgroundColor: Colors.red);
                      //       context.pop();
                      //     }
                      //   }
                      //
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text('Add Kisti', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
}