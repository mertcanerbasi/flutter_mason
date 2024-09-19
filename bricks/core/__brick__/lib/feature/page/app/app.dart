import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/res/theme.dart';
import '../../../core/siren/siren.dart';
import '../../providers/connectivity_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/siren_provider.dart';
import '../../providers/theme_provider.dart';
import '../../router/app_router.dart';
import '../no_connectivity/no_connectivity.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(themeViewModelProvider);
    final localeProvider = ref.watch(localeViewModelProvider);
    final localeNotifier = ref.read(localeViewModelProvider.notifier);
    final connectionProvider = ref.watch(connectionViewModelProvider);
    final sirenProvider = ref.watch(sirenViewModelProvider);
    final sirenNotifier = ref.read(sirenViewModelProvider.notifier);

    return MaterialApp(
        theme: LightTheme().theme(),
        darkTheme: DarkTheme().theme(),
        themeMode: themeProvider,
        initialRoute: RouteMaps.root,
        onGenerateRoute: onGenerateRoute,
        locale: localeProvider,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        localeResolutionCallback: (locale, supportedLocales) {
          if (Platform.isAndroid) {
            return localeProvider;
          }
          localeNotifier.setLocale(Locale(locale!.languageCode.split("_")[0]));
          return Locale(locale.languageCode.split("_")[0]);
        },
        builder: (context, child) {
          if (sirenProvider == SirenType.force) {
            return ForceUpdatePage(update: () {
              if (Platform.isIOS) {
                launchUrl(Uri.parse(
                    "https://apps.apple.com/tr/app/{appname}/{appId}"));
              }

              if (Platform.isAndroid) {
                launchUrl(Uri.parse(
                    "https://play.google.com/store/apps/details?id=${sirenNotifier.packageName}"));
              }
            });
          }
          return GestureDetector(
            child: Stack(
              children: [
                child!,
                if (!connectionProvider) const NoConnectivityPage()
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
