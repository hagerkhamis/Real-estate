import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_assets.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    // 5 second delay as requested
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) context.go('/login');
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glow Effects
          Positioned(
            top: -100.h,
            left: -100.w,
            child: Container(
              width: 300.w,
              height: 300.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
          ),
          
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Image
                  Image.asset(
                    AppAssets.logo,
                    width: 280.w,
                    height: 280.w,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          
          // Custom Loading Bar at bottom
          Positioned(
            bottom: 80.h,
            left: 50.w,
            right: 50.w,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    minHeight: 4.h,
                    backgroundColor: AppColors.divider,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'جاري التحميل...', // Loading... in Arabic
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
