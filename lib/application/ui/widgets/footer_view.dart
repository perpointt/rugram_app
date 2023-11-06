import 'package:flutter/material.dart';

class FooterView extends StatelessWidget {
  final List<Widget> children;
  final Widget? footer;
  final EdgeInsets padding;
  const FooterView({
    super.key,
    this.children = const <Widget>[],
    this.footer,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final footer = this.footer;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Column(children: children),
                if (footer != null) footer,
              ],
            ),
          ),
        );
      },
    );
  }
}
