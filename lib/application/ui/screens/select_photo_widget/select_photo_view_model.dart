import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class SelectPhotoViewModel extends ChangeNotifier {
  SelectPhotoViewModel(BuildContext context) {
    _setBounds(context);
  }
  late final double minHeight;
  late final double maxHeight;

  late double _backdropHeight;
  double get backdropHeight => _backdropHeight;

  final controller = PanelController();

  void _setBounds(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final height =
        size.width + (AppBar().preferredSize.height * 2) + padding.top;
    minHeight = height * 0.4;
    maxHeight = height;
    _backdropHeight = (maxHeight - minHeight);
  }

  void onPanelSlide(double value) {
    _backdropHeight = (maxHeight - minHeight) * value;
    notifyListeners();
  }
}
