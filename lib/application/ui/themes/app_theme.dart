part of 'themes.dart';

abstract class AppTheme {
  static final dark = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    tabBarTheme: const TabBarTheme(
      indicator: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(color: Colors.white, width: 1),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      shadowColor: AppColors.appbarShadow,
      elevation: 0.5,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedIconTheme: IconThemeData(
        color: AppColors.accent,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(),
    inputDecorationTheme: InputDecorationTheme(
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
      hintStyle: AppTextStyle.primary600.copyWith(
        color: Colors.white.withOpacity(0.6),
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      fillColor: AppColors.secondary,
      filled: true,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    tabBarTheme: const TabBarTheme(
      indicator: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      shadowColor: AppColors.appbarShadow,
      elevation: 0.5,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: AppColors.accent,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
    ),
    buttonTheme: const ButtonThemeData(),
    inputDecorationTheme: InputDecorationTheme(
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
      hintStyle: AppTextStyle.primary600.copyWith(
        color: Colors.black.withOpacity(0.6),
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      fillColor: Colors.grey.withOpacity(0.4),
      filled: true,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  );

  static const shadow = BoxShadow(
    color: Color(0x66000000),
    blurRadius: 4,
    offset: Offset(0, 0),
    spreadRadius: 0,
  );

  static var border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white.withOpacity(0.2),
      width: 0.5,
    ),
    borderRadius: BorderRadius.circular(5),
  );
}
