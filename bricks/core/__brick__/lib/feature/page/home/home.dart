import '../../../core/base/base_widget.dart';
import './home_vm.dart';
import '../../../core/res/icons.dart';
import '../../../core/res/l10n/l10n.dart';
import '../../router/app_router.routes.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap(name: "home")
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomeViewModel, HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(context.l10n.home),
      actions: [
        IconButton.filled(
            onPressed: () {
              SettingsRoute().push(context);
            },
            icon: const Icon(AppIcons.settings))
      ],
    ));
  }
}
