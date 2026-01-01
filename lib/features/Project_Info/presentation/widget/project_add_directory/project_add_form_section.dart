import 'package:flutter/material.dart';

class ProjectAddFormSection extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Widget child;

  const ProjectAddFormSection({super.key, required this.icon, required this.iconColor, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
