
import 'package:flutter/material.dart';

enum HeatAlertSectionType { importance, forecast, warningLevels }

class HeatAlertSection {
  final String title;
  final IconData icon;
  final Color color;
  final HeatAlertSectionType type;

  HeatAlertSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.type,
  });
}