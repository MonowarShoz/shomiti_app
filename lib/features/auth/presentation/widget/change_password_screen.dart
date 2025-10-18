// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:school_notebook/features/auth/presentation/provider/change_password_notifier.dart';

// class ChangePasswordScreen extends ConsumerStatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _phoneController = TextEditingController();
//   final _currentPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool _obscureCurrentPassword = true;
//   bool _obscureNewPassword = true;
//   bool _obscureConfirmPassword = true;

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final changePasswordState = ref.watch(changePasswordNotifierProvider);

//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           'Change Password',
//           style: TextStyle(
//             color: Color(0xFF374151),
//             fontWeight: FontWeight.w700,
//             fontSize: 20,
//             letterSpacing: -0.5,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//           color: const Color(0xFF374151),
//           onPressed: () {
//             if (Navigator.canPop(context)) {
//               Navigator.pop(context);
//             } else {
//               //context.go(Routes.home);
//             }
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Header with Icon
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(32),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xFFEF4444).withOpacity(0.3),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.lock_reset,
//                         size: 48,
//                         color: Color(0xFFEF4444),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Update Your Password',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                       letterSpacing: -0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Enter your details to change password',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.white.withOpacity(0.9),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Form Container
//             Container(
//               margin: const EdgeInsets.all(16),
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(24),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.08),
//                     blurRadius: 20,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Phone Number Field
//                     const Text(
//                       'Phone Number',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF374151),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         controller: _phoneController,
//                         keyboardType: TextInputType.phone,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF374151),
//                         ),
//                         decoration: InputDecoration(
//                           hintText: 'Enter your phone number',
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade400,
//                             fontSize: 14,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide.none,
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey.shade50,
//                           contentPadding: const EdgeInsets.all(16),
//                           prefixIcon: const Icon(
//                             Icons.phone_outlined,
//                             color: Color(0xFFEF4444),
//                             size: 20,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter phone number';
//                           }
//                           if (value.length < 10) {
//                             return 'Phone number must be at least 10 digits';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // Current Password Field
//                     const Text(
//                       'Current Password',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF374151),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         controller: _currentPasswordController,
//                         obscureText: _obscureCurrentPassword,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF374151),
//                         ),
//                         decoration: InputDecoration(
//                           hintText: 'Enter current password',
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade400,
//                             fontSize: 14,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide.none,
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey.shade50,
//                           contentPadding: const EdgeInsets.all(16),
//                           prefixIcon: const Icon(
//                             Icons.lock_outline,
//                             color: Color(0xFFEF4444),
//                             size: 20,
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscureCurrentPassword
//                                   ? Icons.visibility_off_outlined
//                                   : Icons.visibility_outlined,
//                               color: Colors.grey.shade600,
//                               size: 20,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscureCurrentPassword = !_obscureCurrentPassword;
//                               });
//                             },
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter current password';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // New Password Field
//                     const Text(
//                       'New Password',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF374151),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         controller: _newPasswordController,
//                         obscureText: _obscureNewPassword,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF374151),
//                         ),
//                         decoration: InputDecoration(
//                           hintText: 'Enter new password',
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade400,
//                             fontSize: 14,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide.none,
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey.shade50,
//                           contentPadding: const EdgeInsets.all(16),
//                           prefixIcon: const Icon(
//                             Icons.lock_open_outlined,
//                             color: Color(0xFFEF4444),
//                             size: 20,
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscureNewPassword
//                                   ? Icons.visibility_off_outlined
//                                   : Icons.visibility_outlined,
//                               color: Colors.grey.shade600,
//                               size: 20,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscureNewPassword = !_obscureNewPassword;
//                               });
//                             },
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter new password';
//                           }
//                           if (value.length < 6) {
//                             return 'Password must be at least 6 characters';
//                           }
//                           if (value == _currentPasswordController.text) {
//                             return 'New password must be different from current';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // Confirm Password Field
//                     const Text(
//                       'Confirm New Password',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF374151),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         controller: _confirmPasswordController,
//                         obscureText: _obscureConfirmPassword,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF374151),
//                         ),
//                         decoration: InputDecoration(
//                           hintText: 'Confirm new password',
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade400,
//                             fontSize: 14,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide.none,
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey.shade50,
//                           contentPadding: const EdgeInsets.all(16),
//                           prefixIcon: const Icon(
//                             Icons.lock_clock_outlined,
//                             color: Color(0xFFEF4444),
//                             size: 20,
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscureConfirmPassword
//                                   ? Icons.visibility_off_outlined
//                                   : Icons.visibility_outlined,
//                               color: Colors.grey.shade600,
//                               size: 20,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscureConfirmPassword = !_obscureConfirmPassword;
//                               });
//                             },
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please confirm new password';
//                           }
//                           if (value != _newPasswordController.text) {
//                             return 'Passwords do not match';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // Password Requirements
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade50,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.blue.shade200),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.info_outline,
//                                 size: 16,
//                                 color: Colors.blue.shade700,
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'Password Requirements',
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.blue.shade700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           _buildRequirement('At least 6 characters long'),
//                           _buildRequirement('Different from current password'),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // Status Messages
//                     if (changePasswordState.isLoading)
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.shade50,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: Colors.blue.shade200),
//                         ),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 color: Colors.blue.shade600,
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Text(
//                                 'Changing password...',
//                                 style: TextStyle(
//                                   color: Colors.blue.shade700,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                     if (changePasswordState.hasError)
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.red.shade50,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: Colors.red.shade200),
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.error_outline,
//                               color: Colors.red.shade600,
//                               size: 20,
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Failed to change password',
//                                     style: TextStyle(
//                                       color: Colors.red.shade700,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     changePasswordState.error.toString(),
//                                     style: TextStyle(
//                                       color: Colors.red.shade600,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                     if (changePasswordState.isLoading || changePasswordState.hasError)
//                       const SizedBox(height: 24),

//                     // Submit Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFEF4444),
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           elevation: 0,
//                         ),
//                         onPressed: changePasswordState.isLoading
//                             ? null
//                             : () => _handleChangePassword(),
//                         child: changePasswordState.isLoading
//                             ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             : const Text(
//                                 'Change Password',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRequirement(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 4),
//       child: Row(
//         children: [
//           Icon(
//             Icons.check_circle_outline,
//             size: 14,
//             color: Colors.blue.shade600,
//           ),
//           const SizedBox(width: 6),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.blue.shade700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _handleChangePassword() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       // await ref.read(changePasswordNotifierProvider.notifier).changePassword(
//       //       phone: _phoneController.text.trim(),
//       //       currentPassword: _currentPasswordController.text,
//       //       newPassword: _newPasswordController.text,
//       //     );

//       final result = ref.read(changePasswordNotifierProvider);
//       if (result.hasValue && result.value != null) {
//         if (mounted && context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: const Row(
//                 children: [
//                   Icon(Icons.check_circle, color: Colors.white),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text('Password changed successfully'),
//                   ),
//                 ],
//               ),
//               backgroundColor: Colors.green.shade600,
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           );
//           Navigator.pop(context);
//         }
//       }
//     }
//   }
// }