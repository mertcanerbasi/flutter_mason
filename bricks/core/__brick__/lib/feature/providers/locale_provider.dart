import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../core/di/locator.dart';
import '../../core/source/local_data_source.dart';

@injectable
class LocaleViewModel extends StateNotifier<Locale?> {
  final LocalDataSource _localDataSource;

  // Constructor with dependency injection for LocalDataSource
  LocaleViewModel(this._localDataSource) : super(null) {
    _init();
  }

  // Initialize the locale based on saved preference
  void _init() {
    final locale = _localDataSource.locale;
    state = locale;
  }

  // Set locale and update the state
  Future<void> setLocale(Locale locale) async {
    await _localDataSource.setLocale(locale);
    state = locale;
  }
}

// Riverpod provider for LocaleViewModel
final localeViewModelProvider =
    StateNotifierProvider<LocaleViewModel, Locale?>((ref) {
  return getIt<LocaleViewModel>(); // Retrieve LocaleViewModel from get_it
});
