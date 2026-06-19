import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  static const _tabs = [
    (path: '/home',     icon: Icons.home_outlined,         activeIcon: Icons.home,         label: 'Home'),
    (path: '/routines', icon: Icons.list_alt_outlined,     activeIcon: Icons.list_alt,     label: 'Routines'),
    (path: '/workout',  icon: Icons.fitness_center_outlined, activeIcon: Icons.fitness_center, label: 'Workout'),
    (path: '/progress', icon: Icons.bar_chart_outlined,    activeIcon: Icons.bar_chart,    label: 'Progress'),
    (path: '/settings', icon: Icons.settings_outlined,     activeIcon: Icons.settings,     label: 'Settings'),
  ];

  int _locationToIndex(String location) {
    for (var i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].path)) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) => context.go(_tabs[i].path),
        destinations: _tabs
            .map((t) => NavigationDestination(
                  icon: Icon(t.icon),
                  selectedIcon: Icon(t.activeIcon),
                  label: t.label,
                ))
            .toList(),
      ),
    );
  }
}
