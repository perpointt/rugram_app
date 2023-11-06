import 'package:flutter/material.dart';

class FooterView extends StatelessWidget {
  final List<Widget> children;
  final Widget? footer;
  const FooterView({
    super.key,
    this.children = const <Widget>[],
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final footer = this.footer;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
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
