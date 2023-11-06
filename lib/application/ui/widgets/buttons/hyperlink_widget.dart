part of 'buttons.dart';

class HyperlinkWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final EdgeInsets margin;
  final List<String> prefix;
  final TextStyle hyperlinkStyle;
  final TextStyle style;
  final TextAlign textAlign;

  const HyperlinkWidget({
    Key? key,
    this.text = '',
    this.onTap,
    this.margin = EdgeInsets.zero,
    this.prefix = const <String>[],
    this.hyperlinkStyle = AppTextStyle.hyperlink500f12,
    this.style = AppTextStyle.primary400x06,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text.rich(
        TextSpan(
          style: style,
          children: [
            ...prefix.map((e) => TextSpan(text: e)).toList(),
            TextSpan(
              text: text,
              style: hyperlinkStyle,
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
        textAlign: textAlign,
      ),
    );
  }
}
