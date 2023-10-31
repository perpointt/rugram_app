import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/screens/select_photo_widget/select_photo_view_model.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class SelectPhotoScreen extends StatelessWidget {
  const SelectPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SelectPhotoViewModel>();
    return Scaffold(
      body: Stack(
        children: [
          SlidingUpPanel(
            minHeight: viewModel.minHeight,
            maxHeight: viewModel.maxHeight,
            controller: viewModel.controller,
            backdropEnabled: false,
            defaultPanelState: PanelState.OPEN,
            panelBuilder: () => const _EditorWidget(),
            slideDirection: SlideDirection.DOWN,
            onPanelSlide: viewModel.onPanelSlide,
            body: const _BodyWidget(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                AppBar(
                  title: Text(
                    AppNavigator.uri.toString(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _BackdropWidget(),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: 101,
            padding: const EdgeInsets.all(4),
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.zero,
                color: Colors.blue,
                child: Center(
                  child: Text('$index'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BackdropWidget extends StatelessWidget {
  const _BackdropWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SelectPhotoViewModel>();

    return Container(
      margin: EdgeInsets.only(top: viewModel.minHeight),
      height: viewModel.backdropHeight,
      color: Colors.red,
    );
  }
}

class _EditorWidget extends StatelessWidget {
  const _EditorWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          top: true,
          bottom: false,
          child: AppBar(),
        ),
        IgnoreDraggableWidget(
          child: const AspectRatio(
            aspectRatio: 1,
            child: _CropWidget(),
          ),
        ),
        Container(
          width: double.infinity,
          height: 56,
          color: Colors.grey,
        ),
      ],
    );
  }
}

class _CropWidget extends StatelessWidget {
  const _CropWidget();

  @override
  Widget build(BuildContext context) {
    return Cropper(
      overlayType: OverlayType.grid,
      overlayColor: Colors.white,
      cropperKey: GlobalKey(debugLabel: 'cropperKey'),
      image: Image.network(
        'https://i.pinimg.com/originals/6b/4d/18/6b4d18c0b756ab20c3591490dfc10090.jpg',
      ),
    );
  }
}
