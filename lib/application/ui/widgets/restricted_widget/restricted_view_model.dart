import 'package:rugram/domain/services/app_service.dart';

class RestrictedViewModel {
  final _service = AppServiceImpl();

  Future<void> openSettings() {
    return _service.openSettings();
  }
}
