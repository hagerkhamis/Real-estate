import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Based on typical iPhone screen
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Aqari - Real Estate',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
