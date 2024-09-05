import 'package:injectable/injectable.dart';
import '../../source/app_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

@module
abstract class AppModule {
  @Environment(Environment.dev)
  @Environment(Environment.prod)
  @preResolve
  Future<AppStorage> get localDataSource async {
    return SharedPreferences.getInstance().then((value) {
      return AppStorage(value);
    });
  }

  @Environment(Environment.dev)
  @Environment(Environment.prod)
  @preResolve
  Future<PackageInfo> get info => PackageInfo.fromPlatform();

  @Environment(Environment.dev)
  @Environment(Environment.prod)
  Connectivity get connectivity => Connectivity();
}
