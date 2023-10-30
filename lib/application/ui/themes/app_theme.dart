part of 'themes.dart';

abstract class AppTheme {
  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleTextStyle: AppTextStyle.primary,
      titleSpacing: 8,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      iconTheme: IconThemeData(
        color: AppColors.primary,
        opacity: 0.32,
      ),
      actionsIconTheme: IconThemeData(
        color: AppColors.grey400,
        opacity: 1,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      height: 64,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.blue600,
        textStyle: AppTextStyle.hyperlink.copyWith(
          color: AppColors.blue400,
        ),
      ),
    ),
  );

  static const shadow = BoxShadow(
    color: Color(0x66000000),
    blurRadius: 4,
    offset: Offset(0, 0),
    spreadRadius: 0,
  );
}
