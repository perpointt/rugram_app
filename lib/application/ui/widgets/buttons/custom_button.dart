part of 'buttons.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final Color color;
  final Color background;
  final String title;
  final double maxWidth;
  final EdgeInsets margin;

  const CustomButton({
    Key? key,
    this.onTap,
    this.title = '',
    this.color = Colors.white,
    this.background = AppColors.accent,
    this.maxWidth = double.infinity,
    this.margin = EdgeInsets.zero,
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
          ),
          if (onTap == null) ...[
            _ButtonWidget(
              title: title,
              background: background.withOpacity(0.5),
              color: Colors.transparent,
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
  const _ButtonWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.background,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(5),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.primary600.copyWith(color: color),
            ),
          ),
        ),
      ),
    );
  }
}
