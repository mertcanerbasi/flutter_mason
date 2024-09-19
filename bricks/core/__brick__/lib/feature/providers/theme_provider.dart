import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../core/di/locator.dart';
import '../../core/source/local_data_source.dart';

@injectable
class ThemeViewModel extends StateNotifier<ThemeMode> {
  final LocalDataSource _localDataSource;
  ThemeViewModel(this._localDataSource) : super(ThemeMode.light) {
    _init();
  }

  // Tema modunu ayarlama metodu
  void _init() {
    final appearance = _localDataSource.appearance;
    state = appearance;
  }

  // Temayı değiştirme metodu
  Future toggleTheme() async {
    if (state == ThemeMode.light) {
      await _localDataSource.setAppearance(ThemeMode.dark);
      state = ThemeMode.dark;
    } else {
      await _localDataSource.setAppearance(ThemeMode.light);
      state = ThemeMode.light;
    }
  }
}

final themeViewModelProvider =
    StateNotifierProvider<ThemeViewModel, ThemeMode>((ref) {
  return getIt<ThemeViewModel>();
});
