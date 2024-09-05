import '../../../core/base/base_view_model.dart';
import '../../../core/source/local_data_source.dart';
import '../../../core/siren/siren.dart';
import '../../data/repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

@singleton
class AppViewModel extends BaseViewModel {
  final PackageInfo _packageInfo;
  final AppRepository _appRepository;
  final Connectivity _connectivity;
  final LocalDataSource _localDataSource;
  AppViewModel(this._localDataSource, this._packageInfo, this._connectivity,
      this._appRepository) {
    _checkForUpdate();
    _checkConnectivity();
  }
  ConnectivityResult _connectivityStatus = ConnectivityResult.other;
  bool get isConnect => _connectivityStatus != ConnectivityResult.none;
  void _checkConnectivity() {
    _connectivity.onConnectivityChanged.listen((event) {
      _connectivityStatus = event;
      notifyListeners();
    });
  }

  Locale? get locale => _localDataSource.locale;
  Future setLocale(Locale locale) => _localDataSource.setLocale(locale);

  ThemeMode get appearance => _localDataSource.appearance;
  Future setDarkMode(ThemeMode appearance) =>
      _localDataSource.setAppearance(appearance).then((value) {
        notifyListeners();
      });
  SirenType sirenType = SirenType.none;
  String get packageName => _packageInfo.packageName;
  void _checkForUpdate() {
    _appRepository.getAppVersion().then((value) {
      Siren()
        ..majorUpdateAlertType = SirenType.force
        ..minorUpdateAlertType = SirenType.option
        ..patchUpdateAlertType = SirenType.skip
        ..checkVersionName(
            minVersion: value,
            currentVersion: _packageInfo.version,
            onDetectNewVersion: (version, type) {
              sirenType = type;
              notifyListeners();
            });
    });
  }
}
