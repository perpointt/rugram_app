part of 'themes.dart';

abstract class AppTextStyle {
  static const primary = TextStyle(
    color: AppColors.primary,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const primary200 = TextStyle(
    color: AppColors.primary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const primary400 = TextStyle(
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const secondary = TextStyle(
    color: AppColors.secondary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const button = TextStyle(
    color: AppColors.blue400,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const button200 = TextStyle(
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const hyperlink = TextStyle(
    color: AppColors.blue200,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
