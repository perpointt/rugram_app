import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/screens/camera_widget/camera_screen.dart';
import 'package:rugram/application/ui/screens/camera_widget/camera_view_model.dart';
import 'package:rugram/application/ui/screens/create_post_widget/create_post_screen.dart';
import 'package:rugram/application/ui/screens/create_post_widget/create_post_view_model.dart';
import 'package:rugram/application/ui/screens/home_widget/home_screen.dart';
import 'package:rugram/application/ui/screens/home_widget/home_view_model.dart';
import 'package:rugram/application/ui/screens/main_screen/main_screen.dart';
import 'package:rugram/application/ui/screens/profile_widget/profile_screen.dart';
import 'package:rugram/application/ui/screens/profile_widget/profile_view_model.dart';
import 'package:rugram/application/ui/screens/select_photo_widget/select_photo_screen.dart';
import 'package:rugram/application/ui/screens/select_photo_widget/select_photo_view_model.dart';
import 'package:rugram/application/ui/screens/welcome_widget/welcome_screen.dart';

@RoutePage()
class AppScreenFactory extends StatelessWidget {
  const AppScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

@RoutePage()
class HomeScreenFactory extends StatelessWidget {
  const HomeScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => HomeViewModel(),
      child: const HomeScreen(),
    );
  }
}

@RoutePage()
class WelcomeScreenFactory extends StatelessWidget {
  const WelcomeScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreen();
  }
}

@RoutePage()
class ProfileScreenFactory extends StatelessWidget {
  const ProfileScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ProfileViewModel(),
      child: const ProfileScreen(),
    );
  }
}

@RoutePage()
class CameraScreenFactory extends StatelessWidget {
  const CameraScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CameraViewModel(context),
      child: const CameraScreen(),
    );
  }
}

@RoutePage()
class SelectPhotoScreenFactory extends StatelessWidget {
  const SelectPhotoScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectPhotoViewModel(context),
      child: const SelectPhotoScreen(),
    );
  }
}

@RoutePage()
class CreatePostScreenFactory extends StatelessWidget {
  final List<File> files;
  const CreatePostScreenFactory({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CreatePostViewModel(files),
      child: const CreatePostScreen(),
    );
  }
}

@RoutePage()
class MainScreenFactory extends StatelessWidget {
  const MainScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}
