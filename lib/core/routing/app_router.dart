

import 'package:flutter/material.dart';
import 'package:learning_center_system/core/routing/routes.dart';
import 'package:learning_center_system/features/home%20page/presentation/views/home_page.dart';
import 'package:learning_center_system/features/sign%20in/presentation/views/sign_in_page.dart';

class AppRouter {
  static Route? onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signInPage:
        return MaterialPageRoute(
          builder: (_) {
            return const SignInPage();
          },
        );
              case Routes.homePage:
        return MaterialPageRoute(
          builder: (_) {
            return HomePage();
          },
        );
    

      default:
        return null;
    }
  }
}

