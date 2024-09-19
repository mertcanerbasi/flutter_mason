import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './core/di/locator.dart';
import './core/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder, String env) async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
      FlutterError.dumpErrorToConsole(details);
    };
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    await setupDI(env);
    runApp(ProviderScope(child: await builder()));
  }, (error, stackTrace) {
    Log.e(error.toString(), tag: "Zone Error");
    Log.e(stackTrace.toString(), tag: "Zone StackTrace");
  });
}
