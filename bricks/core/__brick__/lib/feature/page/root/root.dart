import '../../../core/res/l10n/l10n.dart';
import '../../router/app_router.dart';
import '../../router/app_router.routes.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RouteMap(name: "/")
class RootPage extends StatefulWidget {
  const RootPage({super.key});
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends BaseState<RootViewModel, RootPage> {
  final List<NavItemModel> _items = [
    NavItemModel(
        icon: Icons.home,
        label: (c) => c.l10n.home,
        route: RouteMaps.homeRoute,
        key: GlobalKey<NavigatorState>()),
    NavItemModel(
        icon: Icons.settings,
        label: (c) => c.l10n.settings,
        route: RouteMaps.settingsRoute,
        key: GlobalKey<NavigatorState>()),
  ];
  int currentIndex = 0;
  Widget get content => TabSwitchingView(
      currentTabIndex: currentIndex,
      tabCount: _items.length,
      tabBuilder: (c, index) => Navigator(
          key: _items[index].key,
          initialRoute: _items[index].route,
          onUnknownRoute: (settings) => MaterialPageRoute(
              builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('unknown')),
                  )),
          onGenerateRoute: onGenerateRoute));
  @override
  Widget build(BuildContext context) => Scaffold(
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (i) {
          currentIndex = i;
          setState(() {});
        },
        items: _items
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon),
                  label: e.label(context),
                ))
            .toList(),
      ));
}

class NavItemModel {
  NavItemModel({
    required this.icon,
    required this.label,
    required this.route,
    required this.key,
  });
  final IconData icon;
  final String Function(BuildContext context) label;
  final String route;
  final GlobalKey<NavigatorState> key;
}
