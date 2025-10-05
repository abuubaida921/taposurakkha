import 'package:flutter/material.dart';
import 'dart:math' as Math;

// Beautiful animated loader widget
class BeautifulLoader extends StatefulWidget {
  const BeautifulLoader({super.key, this.size = 48});
  final double size;
  @override
  State<BeautifulLoader> createState() => _BeautifulLoaderState();
}

class _BeautifulLoaderState extends State<BeautifulLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 6.28319, // 2*pi
            child: CustomPaint(
              painter: _SunLoaderPainter(),
              child: Center(
                child: Icon(Icons.wb_sunny, color: Colors.amber.shade700, size: widget.size * 0.55),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SunLoaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = const LinearGradient(colors: [Color(0xFFFFF176), Color(0xFFFFA000)]).createShader(Rect.fromCircle(center: Offset(size.width/2, size.height/2), radius: size.width/2))
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final center = Offset(size.width/2, size.height/2);
    final radius = size.width/2 - 6;
    for (int i = 0; i < 12; i++) {
      final angle = i * 6.28319 / 12;
      final start = Offset(center.dx + radius * 0.8 * Math.cos(angle), center.dy + radius * 0.8 * Math.sin(angle));
      final end = Offset(center.dx + radius * Math.cos(angle), center.dy + radius * Math.sin(angle));
      canvas.drawLine(start, end, paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}