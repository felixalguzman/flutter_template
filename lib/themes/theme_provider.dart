

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final lightThemeProvider = Provider<FlexScheme>((_) => FlexScheme.blumineBlue);
final darkThemeProvider = Provider<FlexScheme>((_) => FlexScheme.blumineBlue);

final themesProvider =
    StateNotifierProvider<ThemesProvider, ThemeMode?>((_) => ThemesProvider());

class ThemesProvider extends StateNotifier<ThemeMode?> {
  ThemesProvider() : super(ThemeMode.dark);
  void changeTheme(bool isOn) {
    state = isOn ? ThemeMode.dark : ThemeMode.light;
  }

  void toggle() =>
      state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
}