import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/siren/siren.dart';
import '../data/repository/app_repository.dart';

@injectable
class SirenViewModel extends StateNotifier<SirenType> {
  final AppRepository _appRepository;
  final PackageInfo _packageInfo;

  // Default to no update available
  SirenViewModel(this._appRepository, this._packageInfo)
      : super(SirenType.none) {
    _checkForUpdate();
  }

  late String _currentVersion;
  String get currentVersion => _currentVersion;

  // Check for new app updates and set the state accordingly
  void _checkForUpdate() async {
    final serverVersion = await _appRepository.getAppVersion();
    _currentVersion = _packageInfo.version;

    Siren siren = Siren()
      ..majorUpdateAlertType = SirenType.force
      ..minorUpdateAlertType = SirenType.option
      ..patchUpdateAlertType = SirenType.skip;

    siren.checkVersionName(
      minVersion: serverVersion,
      currentVersion: currentVersion,
      onDetectNewVersion: (version, type) {
        state = type; // Update the state with the detected update type
      },
    );
  }

  String get packageName => _packageInfo.packageName;
}

final sirenViewModelProvider =
    StateNotifierProvider<SirenViewModel, SirenType>((ref) {
  return getIt<SirenViewModel>(); // Retrieve SirenViewModel from get_it
});
