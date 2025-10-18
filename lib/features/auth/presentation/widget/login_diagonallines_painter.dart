import 'package:flutter/material.dart';

class DiagonalLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF92400E) // Darker yellow/brown
      ..strokeWidth = 2;

    for (int i = 0; i < 10; i++) {
      double startX = i * 15.0;
      double startY = 0;
      double endX = i * 15.0 + size.height;
      double endY = size.height;
      
      if (startX < size.width) {
        canvas.drawLine(
          Offset(startX, startY),
          Offset(endX > size.width ? size.width : endX, 
                 endX > size.width ? size.height - (endX - size.width) : endY),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}