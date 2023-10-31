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

  Future<List<GalleryPhoto>> fetchPhotos(int page) async {
    final photos = await _fetchPhotos(page);
    return _mapEntities(photos);
  }

  Future<List<AssetEntity>> _fetchPhotos(int page) {
    return _entity.getAssetListPaged(page: page, size: 200);
  }

  Future<List<GalleryPhoto>> _mapEntities(List<AssetEntity> photos) async {
    final items = photos.map((e) => GalleryPhoto(e)).toList();
    await items.load();
    return items;
  }
}

extension GalleryPhotoExt on List<GalleryPhoto?> {
  Future<void> load() async {
    await Future.forEach(this, (photo) async {
      await photo?.load();
    });
  }

  int getIndex(String id) {
    return indexWhere((element) => element?.id == id);
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
  late final AssetEntity _entity;
  late final String id;

  File? _file;
  File? get file => _file;

  GlobalKey? _key;
  GlobalKey? get key => _key;

  GalleryPhoto(AssetEntity entity) {
    _entity = entity;
    id = entity.id;
  }

  Future<void> load() async {
    _file ??= await _entity.loadFile();
  }

  void setGlobalKey() {
    _key ??= GlobalKey();
  }
}

class EditorSelect {
  final int stackIndex;
  final List<GalleryPhoto?> selectedPhotos;

  EditorSelect(this.stackIndex, this.selectedPhotos);
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

  int _page = 0;

  List<GalleryPhoto?> _selectedPhotos = <GalleryPhoto?>[];
  List<GalleryPhoto?> get selectedPhotos => _selectedPhotos;

  int _stackIndex = 0;
  int get stackIndex => _stackIndex;

  EditorSelect get editorSelect {
    return EditorSelect(_stackIndex, _selectedPhotos);
  }

  Future<void> _init() async {
    await PhotoManager.setIgnorePermissionCheck(true);
    _isPermissionGranted = await _photosPermissionService.request();
    notifyListeners();

    if (_isPermissionGranted) {
      final paths = await PhotoManager.getAssetPathList();

      final folders = _mapPathEntites(paths);
      _folders = folders;
      notifyListeners();

      final recents = _getRecentsFolder();

      if (recents == null) return;

      final photos = await recents.fetchPhotos(_page);
      _photos = photos;
      notifyListeners();
    }
  }

  Future<void> addSelectedPhoto(GalleryPhoto photo) async {
    final index = _selectedPhotos.getIndex(photo.id);

    if (index == -1) {
      await photo.load();
      final file = photo.file;
      if (file == null) return;

      photo.setGlobalKey();
      final items = List<GalleryPhoto?>.from(_selectedPhotos);
      final firstAvaliableIndex = items.firstAvaliableIndex;
      if (firstAvaliableIndex == -1) {
        items.add(photo);
        _selectedPhotos = items;
        _setStackIndex(items.indexOf(photo));
      } else {
        items[items.firstAvaliableIndex] = photo;
        _selectedPhotos = items;
        _setStackIndex(firstAvaliableIndex);
      }
    } else if (_stackIndex != index) {
      _setStackIndex(index);
    } else {
      final items = List<GalleryPhoto?>.from(_selectedPhotos);
      items[index] = null;

      if (items.isItemsEmpty) {
        _selectedPhotos = [];
        _setStackIndex(0);
      } else {
        _selectedPhotos = items;
        _setStackIndex(_selectedPhotos.lastUnAvaliableIndex);
      }
    }
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
