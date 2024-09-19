import 'dart:io';
import '../../../core/res/icons.dart';
import '../../../core/res/l10n/app_localizations.dart';
import '../../../core/res/l10n/l10n.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../feature/providers/locale_provider.dart';
import '../../../feature/providers/siren_provider.dart';
import '../../../feature/providers/theme_provider.dart';
import 'package:route_map/route_map.dart';

@RouteMap(name: "settings")
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends BaseState<SettingsViewModel, SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            ListTile(
              onTap: () {
                if (Platform.isIOS) {
                  AppSettings.openAppSettings(type: AppSettingsType.appLocale);
                } else if (Platform.isAndroid) {
                  showModalBottomSheet<Locale?>(
                      showDragHandle: true,
                      context: context,
                      useRootNavigator: true,
                      builder: (c) => ListView.builder(
                          shrinkWrap: true,
                          itemCount: AppLocalizations.supportedLocales.length,
                          itemBuilder: (c, i) {
                            var item = AppLocalizations.supportedLocales[i];
                            return ListTile(
                              onTap: () {
                                Navigator.pop(c, item);
                              },
                              title: Text(item.fullName()),
                            );
                          })).then((value) {
                    if (value != null) {
                      getIt<AppViewModel>().setLocale(value);
                      Restart.restartApp();
                    }
                  });
                }
              },
              title: Text(context.l10n.language),
              leading: const Icon(AppIcons.language),
              trailing: const Icon(AppIcons.chevronRight),
            ),
            const Divider(),
            Consumer(
                viewModel: getIt<AppViewModel>(),
                builder: (context, vm) {
                  return ListTile(
                    title: Text(context.l10n.appearance),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          useRootNavigator: true,
                          builder: (c) => SingleChildScrollView(
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      RadioListTile<ThemeMode>(
                                        value: ThemeMode.light,
                                        groupValue: vm.appearance,
                                        onChanged: (v) {
                                          vm.setDarkMode(ThemeMode.light);
                                          Navigator.pop(c);
                                        },
                                        title: Text(context.l10n.light),
                                      ),
                                      RadioListTile(
                                        value: ThemeMode.dark,
                                        groupValue: vm.appearance,
                                        onChanged: (v) {
                                          vm.setDarkMode(ThemeMode.dark);
                                          Navigator.pop(c);
                                        },
                                        title: Text(context.l10n.dark),
                                      ),
                                      RadioListTile(
                                        value: ThemeMode.system,
                                        groupValue: vm.appearance,
                                        onChanged: (v) {
                                          vm.setDarkMode(ThemeMode.system);
                                          Navigator.pop(c);
                                        },
                                        title: Text(context.l10n.systemDefault),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                    },
                    leading: const Icon(AppIcons.lightMode),
                    trailing: const Icon(AppIcons.chevronRight),
                  );
                }),
            const Divider(),
            ListTile(
              title: Text(context.l10n.version),
              leading: const Icon(AppIcons.version),
              subtitle: Text(viewModel.appVersion),
            ),
            const Divider(),
            ListTile(
              title: Text(context.l10n.licenses),
              leading: const Icon(AppIcons.license),
              trailing: const Icon(AppIcons.chevronRight),
              onTap: () {
                showLicensePage(
                    context: context,
                    useRootNavigator: true,
                    applicationName: viewModel.appName,
                    applicationVersion: viewModel.appVersion,
                    applicationLegalese: "Mertcan Erbaşı");
              },
            )
          ],
        ),
      ),
    );
  }
}
