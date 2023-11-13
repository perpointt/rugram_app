part of 'buttons.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final Color color;
  final Color background;
  final String title;
  final double maxWidth;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final TextStyle? style;

  const CustomButton({
    Key? key,
    this.onTap,
    this.title = '',
    this.color = Colors.white,
    this.background = AppColors.accent,
    this.maxWidth = double.infinity,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Stack(
        children: [
          _ButtonWidget(
            title: title,
            background: background,
            color: color,
            onTap: onTap,
            padding: padding,
            style: style,
          ),
          if (onTap == null) ...[
            _ButtonWidget(
              title: title,
              background: background.withOpacity(0.5),
              color: Colors.transparent,
              padding: padding,
              style: style,
            ),
          ],
        ],
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color color;
  final Color background;
  final EdgeInsets padding;
  final TextStyle? style;

  const _ButtonWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.background,
    this.onTap,
    required this.padding,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Center(
            child: Text(
              title,
              style: style ?? AppTextStyle.primary600.copyWith(color: color),
            ),
          ),
        ),
      ),
    );
  }
}
