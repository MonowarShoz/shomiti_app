import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imsomitiapp/core/base_widget/custom_file_picker.dart';
import 'package:imsomitiapp/core/base_widget/custom_image_picker.dart';
import 'package:imsomitiapp/core/helper/image_helper.dart';
import 'package:imsomitiapp/core/networking/api_error_handler.dart';
import 'package:imsomitiapp/core/theming/text_styles.dart';
import 'package:imsomitiapp/features/Member_info/presentation/provider/member_registration_notifier.dart';

class MemberRegistrationFormScreen extends ConsumerStatefulWidget {
  const MemberRegistrationFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemberRegistrationFormScreenState();
}

class _MemberRegistrationFormScreenState extends ConsumerState<MemberRegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _givenNameController = TextEditingController();
  final _sureNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _nidController = TextEditingController();
  final _bicNoController = TextEditingController();
  final _passportController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _fatherController = TextEditingController();
  final _motherController = TextEditingController();
  final _addressController = TextEditingController();

  int? _selectedGender;
  File? _photoFile;
  File? _identityDocFile;
  String? _photoBase64;
  String? _docuFileString;

  @override
  Widget build(BuildContext context) {
    final memberRegistrationState = ref.watch(memberRegistraionNotifierProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 80,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,

            flexibleSpace: FlexibleSpaceBar(
              title: DefaultTextStyle.merge(
                style: const TextStyle(
                  fontSize: 16, // fix large default font
                  color: Color(0xFF1A1A1A),
                  fontWeight: FontWeight.w600,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black, size: 20),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Member Registration",
                      style: TextStyle(color: Color(0xFF1A1A1A), fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            ),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
                                ),
                                boxShadow: [BoxShadow(color: const Color(0xFF6366F1).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))],
                              ),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.transparent,
                                backgroundImage: _photoBase64 != null ? MemoryImage(dataFromBase64String(_photoBase64!)) : null,
                                child: _photoBase64 == null ? const Icon(Icons.person, size: 50, color: Colors.white) : null,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: _photoBase64 != null
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _photoBase64 = null;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                        child: Center(child: Icon(Icons.clear, color: Colors.white)),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: _pickPhoto,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                                          border: Border.all(color: Colors.white, width: 3),
                                        ),
                                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Upload Profile Photo',
                          style: TextStyle(fontSize: 14, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  _buildModerSection('Personal Information', Icons.person_pin_rounded, [
                    Row(
                      children: [
                        Expanded(
                          child: _buildModernTextField(
                            controller: _givenNameController,
                            label: 'Given Name',
                            hint: 'Enter first name',
                            icon: Icons.person_outline,
                            keyboardType: TextInputType.text,
                            validator: (v) => v?.isEmpty ?? true ? 'Name is Required' : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildModernTextField(
                            controller: _sureNameController,
                            label: 'Surname',
                            hint: 'Enter last name',
                            icon: Icons.person,
                            validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Gender',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                        ),
                        const SizedBox(height: 12),
                        FormField<int>(
                          initialValue: _selectedGender,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null) {
                              return 'Please Select Gender';
                            }
                            return null;
                          },
                          builder: (field) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildGenderCard(1, 'Male', Icons.male, () {
                                        setState(() {
                                          _selectedGender = 1;
                                        });
                                        field.didChange(1);
                                      }),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildGenderCard(2, 'Female', Icons.female, () {
                                        setState(() {
                                          _selectedGender = 2;
                                        });
                                        field.didChange(2);
                                      }),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildGenderCard(3, 'Other', Icons.transgender, () {
                                        setState(() {
                                          _selectedGender = 3;
                                        });
                                        field.didChange(3);
                                      }),
                                    ),
                                  ],
                                ),
                                if (field.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8, left: 12),
                                    child: Text(field.errorText!, style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12)),
                                  ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildModernTextField(
                          controller: _nationalityController,
                          label: 'Nationality',
                          hint: 'Enter nationality',
                          icon: Icons.flag_rounded,
                        ),
                      ],
                    ),
                  ),
                  _buildModerSection('Contact Information', Icons.contact_phone_rounded, [
                    _buildModernTextField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      hint: '+880 XXX XXX XXXX',
                      icon: Icons.phone_android_rounded,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        }
                        if (value.length != 11) {
                          return 'Phone Number must be 11 digits';
                        }
                        return null;
                      },
                    ),
                    _buildModernTextField(
                      controller: _emailController,
                      label: 'Email Address',
                      hint: 'your@email.com',
                      icon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v?.isEmpty ?? true) return 'Email is Required';
                        if (!v!.contains('@')) return 'Email must contain @';
                        return null;
                      },
                    ),
                    _buildModernTextField(
                      controller: _addressController,
                      label: 'Address',
                      hint: 'Enter full address',
                      icon: Icons.home_rounded,
                      maxLines: 3,
                    ),
                  ]),
                  _buildModerSection('Identity Documents', Icons.badge_rounded, [
                    _buildModernTextField(controller: _nidController, label: 'National ID', hint: 'Enter NID number', icon: Icons.badge_outlined),
                    _buildModernTextField(
                      controller: _bicNoController,
                      label: 'BIC Number',
                      hint: 'Enter BIC number',
                      icon: Icons.credit_card_rounded,
                    ),
                    _buildModernTextField(
                      controller: _passportController,
                      label: 'Passport Number',
                      hint: 'Enter passport number',
                      icon: Icons.flight_rounded,
                    ),
                    GestureDetector(
                      onTap: _pickIdentyDocFile,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _docuFileString != null ? const Color(0xFF10B981) : const Color(0xFFE2E8F0), width: 2),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _docuFileString != null ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFF6366F1).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _docuFileString != null ? Icons.check_circle : Icons.upload_file_rounded,
                                color: _docuFileString != null ? const Color(0xFF10B981) : const Color(0xFF6366F1),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _docuFileString != null ? 'Document Uploaded' : 'Upload Identity Document',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: _docuFileString != null ? const Color(0xFF10B981) : const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _docuFileString != null ? 'Tap to change' : 'PDF, PNG, or JPG',
                                    style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
                          ],
                        ),
                      ),
                    ),
                  ]),
                  _buildModerSection('Family Member Information', Icons.family_restroom_rounded, [
                    _buildModernTextField(
                      controller: _fatherController,
                      label: "Father's Name",
                      hint: 'Enter father\'s name',
                      icon: Icons.person_outline,
                    ),
                    _buildModernTextField(
                      controller: _motherController,
                      label: "Mother's Name",
                      hint: 'Enter mother\'s name',
                      icon: Icons.person_outline,
                    ),
                  ]),

                  Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16, left: 16, right: 16),
                    child: ElevatedButton(
                      onPressed: memberRegistrationState.isLoading
                          ? null
                          : () {
                              validateCompleteRegistration(ref);
                            },
                      child: memberRegistrationState.isLoading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : Text(
                              'Complete Registration',
                              style: TextStyles.regularRoboto.copyWith(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                            ),
                    ),
                  ),
                  memberRegistrationState.when(
                    data: (data) {
                      if (data != null && data.isNotEmpty) {
                        final isSuccess = !data.toLowerCase().contains('failed');
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                isSuccess ? 'Member Registration Successful!' : 'Registration Failed',
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
                                    if (isSuccess) {
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
                                    isSuccess ? 'Go to Login' : 'Try Again',
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
                            'Registering your school...',
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
          ),
        ],
      ),
    );
  }

  validateCompleteRegistration(WidgetRef ref) {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(memberRegistraionNotifierProvider.notifier)
          .registerMember(
            givenName: _givenNameController.text,
            sureName: _sureNameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            father: _fatherController.text,
            address: _addressController.text,
            biCNo: _bicNoController.text,
            gender: _selectedGender,
            mother: _motherController.text,
            nationality: _nationalityController.text,
            niD: _nidController.text,
            passportNo: _passportController.text,
            photo: _photoBase64,
            idenDocu: _docuFileString,
          );
    }
  }

  _pickPhoto() async {
    final imageData = await ImagePickerHelper.pickImgbase64();
    if (imageData != null) {
      setState(() {
        _photoBase64 = imageData;
      });
    }
  }

  _pickIdentyDocFile() async {
    final fileData = await FilePickerHelper.pickDocumentBase64();
    if (fileData != null) {
      setState(() {
        _docuFileString = fileData;
      });
    }
  }

  Widget _buildModerSection(String title, IconData icon, List<Widget> children) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...children.map((child) => Padding(padding: const EdgeInsets.only(bottom: 16), child: child)),
        ],
      ),
    );
  }

  Widget _buildGenderCard(int value, String label, IconData icon, VoidCallback onTap) {
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6366F1) : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? const Color(0xFF6366F1) : const Color(0xFFE2E8F0), width: 2),
          boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF6366F1).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))] : [],
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : const Color(0xFF64748B), size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : const Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,

            hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 15),
            prefixIcon: Icon(icon, color: const Color(0xFF94A3B8), size: 22),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: const TextStyle(fontSize: 15, color: Color(0xFF1A1A1A), fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
