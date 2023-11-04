import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:rugram/domain/services/photos_permission_service.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class GalleryFolder {
  late final String name;
  late final bool isAll;
  late final AssetPathEntity _entity;

  GalleryFolder(AssetPathEntity entity) {
    name = entity.name;
    isAll = entity.isAll;
    _entity = entity;
  }

  Future<List<GalleryPhoto>> fetchPhotos([int page = 0]) async {
    final photos = await _fetchPhotos(page);
    return _mapEntities(photos);
  }

  Future<List<AssetEntity>> _fetchPhotos(int page) {
    return _entity.getAssetListPaged(page: page, size: 10000);
  }

  Future<List<GalleryPhoto>> _mapEntities(List<AssetEntity> photos) async {
    final items = photos.map((e) => GalleryPhoto(e)).toList();
    return items;
  }
}

extension GalleryPhotoExt on List<GalleryPhoto?> {
  int getIndex(String id) {
    return indexWhere((element) => element?.entity.id == id);
  }

  List<GalleryPhoto> get avaliable {
    return List<GalleryPhoto>.from(where((photo) => photo != null));
  }

  bool get isItemsEmpty {
    return all((photo) => photo == null);
  }

  int get lastIndex {
    return lastIndexWhere((photo) => photo != null);
  }

  int get firstAvaliableIndex {
    return indexWhere((photo) => photo == null);
  }

  int get lastUnAvaliableIndex {
    return lastIndexWhere((photo) => photo != null);
  }
}

class GalleryPhoto {
  final AssetEntity entity;

  GlobalKey? _key;
  GlobalKey? get key => _key;

  GalleryPhoto(this.entity);

  void setGlobalKey() {
    _key ??= GlobalKey();
  }
}

class EditorSelect {
  final int stackIndex;
  final List<GalleryPhoto?> selectedPhotos;

  EditorSelect(
    this.stackIndex,
    this.selectedPhotos,
  );
}

class SelectPhotoViewModel extends ChangeNotifier {
  SelectPhotoViewModel(BuildContext context) {
    _setBounds(context);
    _init();
  }
  late final double minHeight;
  late final double maxHeight;

  late double _backdropHeight;
  double get backdropHeight => _backdropHeight;

  final controller = PanelController();

  final _photosPermissionService = PhotosPermissionService();

  bool _isPermissionGranted = false;
  bool get isPermissionGranted => _isPermissionGranted;

  var _folders = <GalleryFolder>[];
  List<GalleryFolder> get folders => _folders;

  var _photos = <GalleryPhoto>[];
  List<GalleryPhoto> get photos => _photos;

  List<GalleryPhoto?> _photosInEditor = <GalleryPhoto?>[];
  List<GalleryPhoto?> get photosInEditor => _photosInEditor;

  List<GalleryPhoto?> _selectedPhotos = <GalleryPhoto?>[];
  List<GalleryPhoto?> get selectedPhotos => _selectedPhotos;

  int _stackIndex = 0;
  int get stackIndex => _stackIndex;

  bool _multiple = false;
  bool get multiple => _multiple;

  double _aspectRatio = 1.0;
  double get aspectRatio => _aspectRatio;

  EditorSelect get editorSelect {
    return EditorSelect(_stackIndex, _photosInEditor);
  }

  Future<void> _init() async {
    _isPermissionGranted = await _photosPermissionService.request();
    notifyListeners();

    if (_isPermissionGranted) {
      await PhotoManager.requestPermissionExtend();
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );

      final folders = _mapPathEntites(paths);
      _folders = folders;
      notifyListeners();

      final recents = _getRecentsFolder();

      if (recents == null) return;

      final photos = await recents.fetchPhotos();
      _photos = photos;

      if (_photos.isNotEmpty) {
        addSelectedPhoto(_photos.first);
      } else {
        notifyListeners();
      }
    }
  }

  Future<void> addSelectedPhoto(GalleryPhoto photo) async {
    final selectedIndex = _selectedPhotos.getIndex(photo.entity.id);
    final editorIndex = _photosInEditor.getIndex(photo.entity.id);
    if (selectedIndex == -1) {
      photo.setGlobalKey();

      final items = List<GalleryPhoto?>.from(_selectedPhotos);

      if (multiple || items.isEmpty) {
        items.add(photo);
      } else {
        items[0] = photo;
      }

      _selectedPhotos = items;
      _photosInEditor = items;
      _setStackIndex(items.indexOf(photo));
    } else if (_stackIndex != editorIndex) {
      _setStackIndex(editorIndex);
    } else if (multiple) {
      var editorItems = List<GalleryPhoto?>.from(_photosInEditor);
      var selectedItems = List<GalleryPhoto?>.from(_selectedPhotos);

      editorItems[editorIndex] = null;
      selectedItems.removeAt(selectedIndex);

      if (editorItems.isItemsEmpty) editorItems = [photo];

      _selectedPhotos = selectedItems;
      _photosInEditor = editorItems;
      _setStackIndex(editorItems.lastUnAvaliableIndex);
    }
  }

  void setAspectRatio() {
    if (multiple) return;
    if (_aspectRatio == (4 / 3)) {
      _aspectRatio = 1;
    } else {
      _aspectRatio = 4 / 3;
    }
    notifyListeners();
  }

  void setMultiple(GalleryPhoto photo, bool value) {
    _multiple = value;
    if (getIndexOfPhotoInEditor(photo) == -1) {
      addSelectedPhoto(photo);
    } else {
      notifyListeners();
    }
  }

  bool isPhotoActive(GalleryPhoto photo) {
    if (_photosInEditor.isItemsEmpty) return false;
    return _photosInEditor[_stackIndex]?.entity.id == photo.entity.id;
  }

  int getIndexOfPhotoInEditor(GalleryPhoto photo) {
    return _selectedPhotos.avaliable.indexWhere((element) {
      return element.entity.id == photo.entity.id;
    });
  }

  void _setStackIndex(int index) {
    _stackIndex = index;
    notifyListeners();
  }

  GalleryFolder? _getRecentsFolder() {
    return _folders.firstWhereOrNull((folder) => folder.isAll);
  }

  List<GalleryFolder> _mapPathEntites(List<AssetPathEntity> paths) {
    return paths.map((e) => GalleryFolder(e)).toList();
  }

  void _setBounds(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final appbarHeight = (AppBar().preferredSize.height * 2);
    final height = size.width + appbarHeight + padding.top;
    minHeight = height * 0.4;
    maxHeight = height;
    _backdropHeight = (maxHeight - minHeight);
  }

  void onPanelSlide(double value) {
    _backdropHeight = (maxHeight - minHeight) * value;
    notifyListeners();
  }
}
