import 'package:flutter/material.dart';

final ThemeData CompanyThemeData = new ThemeData(
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    accentColor: CompanyColors.black[500],
    accentColorBrightness: Brightness.light);

class CompanyColors {
  CompanyColors._(); // this basically makes it so you can instantiate this class

  static const _blackPrimaryValue = 0xFF000000;

  static const MaterialColor black = const MaterialColor(
    _blackPrimaryValue,
    const <int, Color>{
      50: const Color(0xFFe0e0e0),
      100: const Color(0xFFb3b3b3),
      200: const Color(0xFF808080),
      300: const Color(0xFF4d4d4d),
      400: const Color(0xFF262626),
      500: const Color(_blackPrimaryValue),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    },
  );
  static const appbar_color = 0xFF005d99;
  static const button_color_new = 0xFF005d99;
  //static const appbar_color = 0xFF8A2953;

  static const statusbar_color = 0xFF137ec2;
  static const boldtext_color = 0xFF4d4d4d;
  static const lighttext_color = 0xFFb3b3b3;
  static const button_color = 0xFF137ec2;
  static const title_color = 0xFF137ec2;
  static const powerbytct_color = 0xFF8c8c8c;
  static const boarder_color = 0xFF137ec2;
  static const clip_background_color = 0xFF137ec2;
  static const tab_background_color = 0xFF137ec2;
  static const tab_selscted_text_color = 0xFFffffff;
  static const tab_unselected_text_color = 0xFFe0e0e0;
  static const tab_indicator_color = 0xFFffffff;
  static const icon_color = 0xFF8bd8f6;
  static const button_txt_color = 0xFFffffff;
  static const appbar_txt_xolor = 0xFFffffff;
  static const delete_icon_color = 0xFFEF9A9A;
  static const edit_icon_color = 0xFFEF9A9A;
  static const actionsheet_icon_color = 0xFFEF9A9A;
  static const actionsheet_txt_color = 0xFF4d4d4d;
  static const shadow_color = 0xFFeeeeee;
  static const box_color = 0xFFEF9A9A;
  static const selected_date_background_color = 0xFFb3b3b3;
  static const unselected_date_background_color = 0xFFffffff;
  static const gradient_color1 = 0xFF5bb0f4;
  static const gradient_color2 = 0xFF5bb0f4;
  static const gradient_color3 = 0xFFcbb4d4;
  static const clear_color = 0xFF00000000;
  static const bluegray = 0xFF424242;
  static const bluegray60 = 0xFF60424242;
  static const white = 0xFFffffff;
  static const appbar_color60 = 0xFF60137ec2;
  static const appbar_color80 = 0xFF80137ec2;
  static const appbar_color40 = 0xFF40137ec2;
  static const appbar_color20 = 0xFF20137ec2;
  static const button_color1 = 0xFF137ec2;
  static const grey = 0xFFf2f2f2;
}