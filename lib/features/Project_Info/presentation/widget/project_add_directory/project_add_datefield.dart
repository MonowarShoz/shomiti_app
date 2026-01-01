import 'package:flutter/material.dart';

class ProjectAddDateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  final String formattedDate;
  const ProjectAddDateField({super.key, required this.label, this.date, required this.onTap, required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: date == null ? Colors.grey[300]! : Colors.blue[200]!,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.event,
                  size: 20,
                  color: date == null ? Colors.grey[400] : Colors.blue[700],
                ),
                const SizedBox(width: 12),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: date == null ? Colors.grey[400] : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
