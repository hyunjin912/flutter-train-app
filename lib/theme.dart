import 'package:flutter/material.dart';

var lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple,
    brightness: Brightness.light,
  ),
  // 박스 색
  primaryColor: Colors.white,
  // // 텍스트 - 활성화
  dividerColor: Colors.black,
  // 앱바 배경
  appBarTheme: AppBarTheme(
    // 리딩, 타이틀 부분
    // foregroundColor: Colors.white,
    // 배경 부분
    backgroundColor: Colors.white,
  ),
  // scaffold body 배경
  scaffoldBackgroundColor: Colors.grey[200],
  // 버튼텍스트 - 비활성화
  highlightColor: const Color.fromARGB(112, 88, 87, 87),
  // 버튼 - 비활성화
  disabledColor: Color.fromRGBO(189, 189, 189, 0.631),
  // 엘레베이티드버튼 활성화
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      backgroundColor: WidgetStatePropertyAll(Colors.purple),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),
);

var darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple,
    brightness: Brightness.dark,
  ),
  // 박스 색
  primaryColor: Color.fromRGBO(66, 66, 66, 1),
  // 텍스트 - 활성화
  dividerColor: Colors.white,
  // 앱바 배경
  appBarTheme: AppBarTheme(
    // 리딩, 타이틀 부분
    foregroundColor: Colors.white,
    // 배경 부분
    backgroundColor: Color.fromRGBO(22, 18, 22, 1),
  ),
  // scaffold body 배경
  scaffoldBackgroundColor: Color.fromRGBO(22, 18, 22, 1),
  // 버튼텍스트 - 비활성화
  highlightColor: const Color.fromARGB(113, 112, 112, 112),
  // 버튼 - 비활성화
  disabledColor: Color.fromRGBO(79, 79, 79, 0.624),
  // 엘레베이티드버튼 활성화
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      backgroundColor: WidgetStatePropertyAll(Colors.purple),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),
);
