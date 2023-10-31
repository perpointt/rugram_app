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
    final isPermissionGranted =
        context.select<SelectPhotoViewModel, bool>((value) {
      return value.isPermissionGranted;
    });
    return Scaffold(
      body: isPermissionGranted
          ? const _BodyWidget()
          : const _NoPermissionWidget(),
    );
  }
}

class _NoPermissionWidget extends StatelessWidget {
  const _NoPermissionWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        const Spacer(),
        const Center(
          child: Text('Предоставьте доступ к камере'),
        ),
        const Spacer(),
      ],
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SelectPhotoViewModel>();

    return Stack(
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
          body: const _GridWidget(),
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
    );
  }
}

class _GridWidget extends StatelessWidget {
  const _GridWidget();

  @override
  Widget build(BuildContext context) {
    final photos =
        context.select<SelectPhotoViewModel, List<GalleryPhoto>>((value) {
      return value.photos;
    });

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
            itemCount: photos.length,
            padding: const EdgeInsets.all(4),
            itemBuilder: (context, index) {
              final photo = photos[index];
              final file = photo.file;
              if (file == null) return const SizedBox.shrink();
              return InkWell(
                onTap: () {
                  context.read<SelectPhotoViewModel>().addSelectedPhoto(photo);
                },
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
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
    final select = context.select<SelectPhotoViewModel, EditorSelect>((value) {
      return value.editorSelect;
    });

    return Column(
      children: [
        SafeArea(
          top: true,
          bottom: false,
          child: AppBar(),
        ),
        IgnoreDraggableWidget(
          child: AspectRatio(
            aspectRatio: 1,
            child: IndexedStack(
              index: select.stackIndex,
              children: select.selectedPhotos.map((photo) {
                return _CropWidget(photo: photo);
              }).toList(),
            ),
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

class _CropWidget extends StatefulWidget {
  final GalleryPhoto? photo;
  const _CropWidget({required this.photo});

  @override
  State<_CropWidget> createState() => _CropWidgetState();
}

class _CropWidgetState extends State<_CropWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final photo = widget.photo;

    if (photo == null) return const SizedBox.shrink();
    final file = photo.file;
    if (file == null) return const SizedBox.shrink();
    return Cropper(
      overlayType: OverlayType.grid,
      overlayColor: Colors.white,
      cropperKey: photo.key,
      image: Image.file(file),
    );
  }
}
