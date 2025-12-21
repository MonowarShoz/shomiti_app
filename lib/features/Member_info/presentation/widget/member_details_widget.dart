import 'package:flutter/material.dart';

import '../../data/data_source/remote/model/member_info_all_model.dart';

class MemberDetailDialog extends StatelessWidget {
  final MemberInfoAllModel memberData;

  const MemberDetailDialog({
    super.key,
    required this.memberData,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          maxWidth: 600,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Modern Header with gradient
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade600, Colors.blue.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${memberData.givenName} ${memberData.sureName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Member #${memberData.memNo}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact Information Card
                    _buildModernCard(
                      title: 'Contact Information',
                      icon: Icons.contact_phone_outlined,
                      color: Colors.blue,
                      children: [
                        _buildModernInfoTile(
                          icon: Icons.phone_outlined,
                          label: 'Phone',
                          value: memberData.phone ?? 'N/A',
                          iconColor: Colors.green,
                        ),
                        _buildModernInfoTile(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: memberData.email ?? 'N/A',
                          iconColor: Colors.orange,
                        ),
                        _buildModernInfoTile(
                          icon: Icons.location_on_outlined,
                          label: 'Address',
                          value: memberData.address ?? 'N/A',
                          iconColor: Colors.red,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Identification Card
                    _buildModernCard(
                      title: 'Identification',
                      icon: Icons.badge_outlined,
                      color: Colors.purple,
                      children: [
                        _buildModernInfoTile(
                          icon: Icons.credit_card,
                          label: 'NID',
                          value: memberData.niD ?? 'N/A',
                          iconColor: Colors.indigo,
                        ),
                        _buildModernInfoTile(
                          icon: Icons.account_balance_wallet_outlined,
                          label: 'BIC No',
                          value: memberData.biCNo ?? 'N/A',
                          iconColor: Colors.teal,
                        ),
                        _buildModernInfoTile(
                          icon: Icons.airplanemode_active,
                          label: 'Passport',
                          value: memberData.passportNo ?? 'N/A',
                          iconColor: Colors.blue,
                        ),
                        _buildModernInfoTile(
                          icon: Icons.flag_outlined,
                          label: 'Nationality',
                          value: memberData.nationality ?? 'N/A',
                          iconColor: Colors.green,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Personal Information Card
                    _buildModernCard(
                      title: 'Personal Details',
                      icon: Icons.person_outline,
                      color: Colors.teal,
                      children: [
                        _buildModernInfoTile(
                          icon: Icons.wc,
                          label: 'Gender',
                          value: memberData.gender ?? 'N/A',
                          iconColor: Colors.pink,
                        ),
                        if (memberData.father?.isNotEmpty == true)
                          _buildModernInfoTile(
                            icon: Icons.man,
                            label: 'Father',
                            value: memberData.father ?? 'N/A',
                            iconColor: Colors.blue,
                          ),
                        if (memberData.mother?.isNotEmpty == true)
                          _buildModernInfoTile(
                            icon: Icons.woman,
                            label: 'Mother',
                            value: memberData.mother ?? 'N/A',
                            iconColor: Colors.purple,
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // System Information
                    _buildModernCard(
                      title: 'System Info',
                      icon: Icons.info_outline,
                      color: Colors.grey,
                      children: [
                        _buildModernInfoTile(
                          icon: Icons.calendar_today,
                          label: 'Created',
                          value: '${memberData.createDate} by ${memberData.createBy}',
                          iconColor: Colors.blueGrey,
                        ),
                        _buildModernInfoTile(
                          icon: Icons.update,
                          label: 'Updated',
                          value: memberData.updateDate ?? 'N/A',
                          iconColor: Colors.blueGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildModernInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
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

// Usage example in your ListView:
// onTap: () {
//   showDialog(
//     context: context,
//     builder: (context) => MemberDetailDialog(memberData: memberData),
//   );
// }