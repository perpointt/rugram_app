import 'package:flutter/cupertino.dart';
import 'package:rugram/application/ui/app_view_model/app_state.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/widgets/dialogs/dialogs.dart';
import 'package:rugram/domain/models/app_exception.dart';

class AppDialogsViewModel {
  Future<void> showLoadingDialog(BuildContext context) {
    return AppNavigator.openLoadingDialog(context);
  }

  Future<void> showConfirmDialog(BuildContext context) {
    return AppNavigator.openDialog(
      context: context,
      dialog: const ConfirmDialog(title: 'title'),
    );
  }

  Future<void> showDialogByState(BuildContext context, AppState state) async {
    if (state is LoadingState) {
      return AppNavigator.openLoadingDialog(context);
    } else if (state is ApiErrorState) {
      return AppNavigator.openDialog(
        context: context,
        dialog: const ConfirmDialog(title: 'title'),
      );
    } else if (state is BadRequestState) {
      return AppNavigator.openDialog(
        context: context,
        dialog: const ConfirmDialog(title: 'title'),
      );
    } else if (state is NoInternetState) {
      return AppNavigator.openDialog(
        context: context,
        dialog: const ConfirmDialog(title: 'title'),
      );
    } else if (state is InternalErrorState) {
      return AppNavigator.openDialog(
        context: context,
        dialog: const ConfirmDialog(title: 'title'),
      );
    }
  }

  Future<void> showDialogByException(BuildContext context, Object exception) {
    if (exception is ApiException) {
      switch (exception.type) {
        case ApiExceptionType.auth:
        case ApiExceptionType.other:
          return AppNavigator.openDialog(
            context: context,
            dialog: const ConfirmDialog(title: 'title'),
          );
        case ApiExceptionType.badRequest:
          return AppNavigator.openDialog(
            context: context,
            dialog: const ConfirmDialog(title: 'title'),
          );
        case ApiExceptionType.timeout:
          return AppNavigator.openDialog(
            context: context,
            dialog: const ConfirmDialog(title: 'title'),
          );
      }
    } else {
      return AppNavigator.openDialog(
        context: context,
        dialog: const ConfirmDialog(title: 'title'),
      );
    }
  }
}
