
import 'package:flutter/material.dart';

class HeatwaveSafetyTipQuestion {
  final String question;
  final List<String>? bulletPoints;
  final List<HeatwaveSafetyTipGroup>? groups;
  final String? specialInfo;
  final IconData icon;
  final Color color;

  HeatwaveSafetyTipQuestion({
    required this.question,
    this.bulletPoints,
    this.groups,
    this.specialInfo,
    required this.icon,
    required this.color,
  });
}

class HeatwaveSafetyTipGroup {
  final String group;
  final String karon;
  final String lokkho;
  final String chobi;
  final List<String> tips;

  HeatwaveSafetyTipGroup({
    required this.group,
    required this.karon,
    required this.lokkho,
    required this.chobi,
    required this.tips,
  });
}