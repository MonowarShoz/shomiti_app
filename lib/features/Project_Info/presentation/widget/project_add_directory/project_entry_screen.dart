import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/base_widget/custom_date_picker.dart';
import 'package:imsomitiapp/core/base_widget/custom_input_field_suffix.dart';
import 'package:imsomitiapp/core/helper/date_converter.dart';
import 'package:imsomitiapp/features/Project_Info/presentation/provider/project_add_notifier.dart';
import 'package:imsomitiapp/features/Project_Info/presentation/widget/project_add_directory/project_add_datefield.dart';
import 'package:imsomitiapp/features/Project_Info/presentation/widget/project_add_directory/project_add_form_section.dart';

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

  @override
  Widget build(BuildContext context) {
    final projectAddState = ref.watch(projectAddNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: Text('ADD Project')),
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:  0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.blue[700],
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Project Timeline',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProjectAddDateField(label: 'Start Date', onTap: () async{
                    final date = await showCustomDatePicker(context: context);
                    if(date != null){
                      setState(() {
                        _startDate = date;
                      });
                    }

                  }, formattedDate:_startDate ==null ? "Select Date" : DateConverter.dateFormatStyle2(_startDate)),
                  ProjectAddDateField(
                    label: 'End Date',
                    date: _endDate,
                    onTap: () async{
                      final date = await showCustomDatePicker(context: context);
                      if(date != null){
                        setState(() {
                          _endDate = date;
                        });
                      }
                    },
                    formattedDate:_endDate ==null ? "Select Date" :  DateConverter.dateFormatStyle2(_endDate),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Create Project',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
