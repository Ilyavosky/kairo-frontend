import 'package:flutter/material.dart';

enum AppSection {
  home(path: '/inicio', label: 'Inicio', icon: Icons.home_rounded),
  activities(
    path: '/actividades',
    label: 'Actividades',
    icon: Icons.library_add_rounded,
  ),
  time(path: '/tiempo', label: 'Tiempo', icon: Icons.watch_later_rounded),
  goals(path: '/metas', label: 'Metas', icon: Icons.star_rounded),
  more(path: '/mas', label: 'Más', icon: Icons.menu_rounded);

  const AppSection({
    required this.path,
    required this.label,
    required this.icon,
  });

  final String path;
  final String label;
  final IconData icon;
}
