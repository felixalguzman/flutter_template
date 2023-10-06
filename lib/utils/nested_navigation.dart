import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../themes/theme_provider.dart';

class NavItem {
  final String label;
  final IconData icon;
  final bool showInNavBar;
  final bool showInNavRail;
  final String route;

  NavItem({
    required this.label,
    required this.icon,
    required this.route,
    this.showInNavBar = false,
    this.showInNavRail = true,
  });
}

final locations = <NavItem>[
  NavItem(
      label: 'Home',
      icon: Icons.home,
      showInNavBar: true,
      showInNavRail: true,
      route: '/'),
  NavItem(
    label: 'Items',
    icon: Icons.rule,
    route: '/items',
    showInNavBar: true,
    showInNavRail: true,
  ),

];

class NestedNavigation extends StatelessWidget {
  const NestedNavigation({
    Key? key,
    required this.state,
    required this.widget,
  }) : super(key: key ?? const ValueKey<String>('NestedNavigation'));

  final Widget widget;
  final GoRouterState state;

  int getCurrentIndex(BuildContext context, bool isMobile) {
    var location = GoRouterState.of(context).uri.toString();
    if (location.length > 1) {
      if (location.contains("/")) {
        location = location.split("/")[1];
      }
      final indexOfParams = location.indexOf("?");
      location =
          location.substring(0, indexOfParams != -1 ? indexOfParams : null);
    }

    final urls = switch (isMobile) {
      true => locations.where((element) => element.showInNavBar == true),
      false => locations.where((element) => element.showInNavRail == true),
    }
        .map((e) => e.route)
        .toList();
    final indexWhere =
        urls.indexWhere((element) => element.split("/")[1] == location);
    if (indexWhere != -1) {
      return indexWhere;
    }

    final indexStartingWith = urls
        .indexWhere((element) => location.startsWith(element.split("/")[1]));

    if (indexStartingWith != -1) {
      return indexStartingWith;
    }

    return urls.length;
  }

  @override
  Widget build(BuildContext context) {
    void goToBranch(int index, bool isMobile) {
      final items = switch (isMobile) {
        true => locations.where((element) => element.showInNavBar == true),
        false => locations.where((element) => element.showInNavRail == true),
      }
          .toList();

      context.go(items[index].route);
    }

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: widget,
          selectedIndex: getCurrentIndex(context, true),
          onDestinationSelected: (value) => goToBranch(value, true),
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: widget,
          selectedIndex: getCurrentIndex(context, false),
          onDestinationSelected: (value) => goToBranch(value, false),
        );
      }
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: locations
            .where((element) => element.showInNavBar)
            .map((e) => NavigationDestination(
                  label: e.label,
                  icon: Icon(e.icon),
                ))
            .toList(),
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}

class ScaffoldWithNavigationRail extends ConsumerWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themesProvider);
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: locations
                .where((element) => element.showInNavRail)
                .map((e) => NavigationRailDestination(
                      label: Text(e.label),
                      icon: Icon(e.icon),
                    ))
                .toList(),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.logout,
                    ),
                    onPressed: () => context.go('/login'),
                  ),
                ),
              ),
            ),
          ),
          VerticalDivider(
            thickness: 1,
            width: 1,
            color: themeMode == ThemeMode.light
                ? const Color.fromARGB(255, 196, 195, 195)
                : null,
          ),
          // This is the main content.
          Expanded(child: body),
        ],
      ),
    );
  }
}
