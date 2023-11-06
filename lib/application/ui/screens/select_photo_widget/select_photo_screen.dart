import 'package:cropperx/cropperx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/screens/select_photo_widget/select_photo_view_model.dart';
import 'package:rugram/application/ui/themes/themes.dart';
import 'package:rugram/application/ui/widgets/restricted_widget/restricted_widget.dart';
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
      body:
          isPermissionGranted ? const _BodyWidget() : const _RestrictedWidget(),
    );
  }
}

class _RestrictedWidget extends StatelessWidget {
  const _RestrictedWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(elevation: 0),
        const Expanded(
          child: RestrictedWidget(
            title: 'Пожалуйста, разрешите доступ к вашим фотографиям',
            description:
                'Это позволит Rugram делиться фотографиями из вашей библиотеки и сохранять фотографии в галерею.',
          ),
        ),
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
          color: Colors.black,
        ),
        const _AppBarWidget(),
      ],
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SelectPhotoViewModel>();

    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          AppBar(
            title: const Text('Новый пост'),
            actions: [
              CupertinoButton(
                onPressed: viewModel.selectedPhotos.isEmpty
                    ? null
                    : () => viewModel.crop(context),
                child: const Text(
                  'Далее',
                  style: AppTextStyle.hyperlink400f14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GridWidget extends StatelessWidget {
  const _GridWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SelectPhotoViewModel>();
    final photos = viewModel.photos;

    return Column(
      children: [
        const _BackdropWidget(),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.5,
            ),
            itemCount: photos.length,
            padding: const EdgeInsets.all(0.5),
            itemBuilder: (context, index) {
              return _ImageWidget(photo: photos[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _ImageWidget extends StatelessWidget {
  final GalleryPhoto photo;
  const _ImageWidget({required this.photo});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SelectPhotoViewModel>();

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GestureDetector(
            onTap: () => viewModel.addSelectedPhoto(photo),
            onLongPress: () => viewModel.setMultiple(photo, true),
            child: AssetEntityImage(
              photo.entity,
              fit: BoxFit.cover,
              isOriginal: false,
            ),
          ),
        ),
        _ActiveImageWidget(photo: photo),
        _ImageIndexWidget(photo: photo),
      ],
    );
  }
}

class _ActiveImageWidget extends StatelessWidget {
  final GalleryPhoto photo;
  const _ActiveImageWidget({required this.photo});

  @override
  Widget build(BuildContext context) {
    final _ =
        context.select<SelectPhotoViewModel, List<GalleryPhoto?>>((value) {
      return value.photosInEditor;
    });

    // ignore: non_constant_identifier_names
    final __ = context.select<SelectPhotoViewModel, int>((value) {
      return value.stackIndex;
    });

    final viewModel = context.read<SelectPhotoViewModel>();

    if (viewModel.isPhotoActive(photo)) {
      return IgnorePointer(
        child: Container(
          color: Colors.white.withOpacity(0.4),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _ImageIndexWidget extends StatelessWidget {
  final GalleryPhoto photo;
  const _ImageIndexWidget({required this.photo});

  @override
  Widget build(BuildContext context) {
    final multiple = context.select<SelectPhotoViewModel, bool>((value) {
      return value.multiple;
    });

    final _ = context.select<SelectPhotoViewModel, int>((value) {
      return value.stackIndex;
    });

    // ignore: non_constant_identifier_names
    final __ =
        context.select<SelectPhotoViewModel, List<GalleryPhoto?>>((value) {
      return value.photosInEditor;
    });

    if (multiple) {
      final viewModel = context.read<SelectPhotoViewModel>();
      final index = viewModel.getIndexOfPhotoInEditor(photo);
      return Align(
        alignment: Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getColor(index),
            border: Border.all(color: Colors.white, width: 1),
          ),
          width: 24,
          height: 24,
          child: Center(
            child: Text(
              '${index == -1 ? '' : index}',
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Color _getColor(int index) {
    return index == -1 ? Colors.white.withOpacity(0.5) : AppColors.accent;
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
      color: Colors.black,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SafeArea(
          top: true,
          bottom: false,
          child: AppBar(),
        ),
        IgnoreDraggableWidget(
          child: AspectRatio(
            aspectRatio: 1,
            child: Center(
              child: select.selectedPhotos.isEmpty
                  ? const _NoMediaWidget()
                  : IndexedStack(
                      alignment: Alignment.center,
                      index: select.stackIndex,
                      children: select.selectedPhotos.map((photo) {
                        return _CropWidget(photo: photo);
                      }).toList(),
                    ),
            ),
          ),
        ),
        const _EditorBottomWudget(),
      ],
    );
  }
}

class _NoMediaWidget extends StatelessWidget {
  const _NoMediaWidget();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Сейчас тут пусто',
          style: AppTextStyle.title,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          'Ваши фотографии и видео появятся здесь.',
          style: AppTextStyle.primary400x06,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _EditorBottomWudget extends StatelessWidget {
  const _EditorBottomWudget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SelectPhotoViewModel>();
    return Container(
      width: double.infinity,
      height: 56,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (viewModel.selectedPhotos.isNotEmpty) ...[
            IconButton(
              onPressed: viewModel.toggleMultiple,
              icon: const Icon(Icons.auto_awesome_motion_outlined),
            ),
          ],
          IconButton(
            onPressed: () => AppNavigator.navigateNamedTo(
              context,
              AppRouteNames.camera,
            ),
            icon: const Icon(Icons.camera_alt_outlined),
          ),
        ],
      ),
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
    final file = photo?.file;

    if (photo == null || file == null) return const SizedBox.shrink();

    final aspectRatio = context.select<SelectPhotoViewModel, double>((value) {
      return value.aspectRatio;
    });

    return Cropper(
      cropperKey: photo.key,
      image: AssetEntityImage(photo.entity),
      overlayType: OverlayType.grid,
      aspectRatio: aspectRatio,
      backgroundColor: Colors.black,
      overlayColor: Colors.white,
      gridLineThickness: 1,
    );
  }
}
