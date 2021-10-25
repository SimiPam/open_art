import 'package:flutter/material.dart';
import 'package:open_art/core/services/storage_service.dart';
import 'package:open_art/shared/models/theme_model.dart';
import 'package:open_art/shared/utils/themes/dark_theme.dart';
import 'package:open_art/shared/utils/themes/hi_light_theme.dart';
import 'package:open_art/shared/utils/themes/light_theme.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:rxdart/rxdart.dart';

class ColorService {
  ColorService(this.storageService);

  StorageService storageService;

  PublishSubject<ThemeModel> color$ = PublishSubject<ThemeModel>();

  void setTheme(ThemeModel theme) {
    pmTheme = theme;
    color$.add(theme);
  }

  List<ThemeModel> get themes {
    return <ThemeModel>[
      lightThemeMode,
      darkThemeMode,
    ];
  }

  ThemeModel getThemeById(String id) {
    return themes.firstWhere((ThemeModel t) => t.id == id, orElse: () => null);
  }

  Color fromHex(String hexString) {
    final StringBuffer buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }

    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({
    bool leadingHashSign = true,
    int alpha,
    int red,
    int green,
    int blue,
  }) {
    return '${leadingHashSign ? '#' : ''}'
        '${alpha.toRadixString(16).padLeft(2, '0')}'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}
