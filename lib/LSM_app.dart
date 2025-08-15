import 'package:flutter/material.dart';
import 'package:learning_center_system/core/routing/app_router.dart';
import 'package:learning_center_system/core/routing/routes.dart';

class LearningSystemManagement extends StatelessWidget {
  const LearningSystemManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      title: 'Learning System Management',

      onGenerateRoute: AppRouter.onGenerate,
      debugShowCheckedModeBanner: false,
      // Set the initial route to the OnBoardingPage
      initialRoute: Routes.homePage,
    );
  }
}
