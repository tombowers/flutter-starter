import 'package:flutter/material.dart';
import 'package:template/pages/details_screen.dart';
import 'package:template/pages/home_screen.dart';
import 'package:template/pages/settings_screen.dart';
import 'package:template/routing/app_route_config.dart';

final routes = <AppRouteConfig>[
  AppRouteConfig(
    path: '/home',
    title: 'Home',
    builder: (_, __) => const HomeScreen(),
    includeInNav: true,
    icon: Icons.home,
    label: 'Home',
  ),
  AppRouteConfig(
    path: '/home/details',
    title: 'Details',
    builder: (_, __) => const DetailsScreen(),
  ),
  AppRouteConfig(
    path: '/settings',
    title: 'Settings',
    builder: (_, __) => const SettingsScreen(),
    includeInNav: true,
    icon: Icons.settings,
    label: 'Settings',
  ),
];
