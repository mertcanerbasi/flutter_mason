import 'dart:io';
import '../../../core/base/base_widget.dart';
import '../../../core/res/theme.dart';
import '../../../core/res/l10n/app_localizations.dart';
import '../no_connectivity/no_connectivity.dart';
import './app_vm.dart';
import '../../router/app_router.dart';
import '../../router/app_router.routes.dart';
import '../../../core//siren/siren.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends BaseState<AppViewModel, App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: LightTheme().theme(),
        darkTheme: DarkTheme().theme(),
        themeMode: viewModel.appearance,
        initialRoute: RouteMaps.root,
        onGenerateRoute: onGenerateRoute,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        localeResolutionCallback: (locale, supportedLocales) {
          if (Platform.isAndroid) {
            return viewModel.locale;
          }
          viewModel.setLocale(Locale(locale!.languageCode.split("_")[0]));
          return Locale(locale!.languageCode.split("_")[0]);
        },
        builder: (context, child) {
          if (viewModel.sirenType == SirenType.force) {
            return ForceUpdatePage(update: () {
              if (Platform.isIOS) {
                launchUrl(Uri.parse(
                    "https://apps.apple.com/tr/app/{appname}/{appId}"));
              }

              if (Platform.isAndroid) {
                launchUrl(Uri.parse(
                    "https://play.google.com/store/apps/details?id=${viewModel.packageName}"));
              }
            });
          }
          return GestureDetector(
            child: Stack(
              children: [
                child!,
                if (!viewModel.isConnect) const NoConnectivityPage()
              ],
            ),
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          );
        },
        supportedLocales: AppLocalizations.supportedLocales);
  }
}
