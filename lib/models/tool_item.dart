import 'package:flutter/material.dart';

class ToolItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Widget page;

  const ToolItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.page,
  });
}