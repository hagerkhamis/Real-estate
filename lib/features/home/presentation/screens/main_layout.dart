import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_application_1/features/add_property/presentation/screens/add_property_screen.dart';
import 'package:flutter_application_1/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:flutter_application_1/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_application_1/features/map/presentation/screens/map_screen.dart';

// Current index provider for bottom nav
final navigationIndexProvider = StateProvider<int>((ref) => 0);

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    final List<Widget> screens = [
      const HomeScreen(),
      const MapScreen(),
      const AddPropertyScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, ref, 0, Icons.home_rounded, 'الرئيسية'),
              _buildNavItem(context, ref, 1, Icons.map_rounded, 'الخريطة'),
              _buildCenterNavItem(context, ref),
              _buildNavItem(context, ref, 3, Icons.favorite_rounded, 'المحفوظة'),
              _buildNavItem(context, ref, 4, Icons.person_rounded, 'حسابي'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, WidgetRef ref, int index, IconData icon, String label) {
    final currentIndex = ref.watch(navigationIndexProvider);
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => ref.read(navigationIndexProvider.notifier).state = index,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textGrey,
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textGrey,
                fontSize: 10.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterNavItem(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(navigationIndexProvider.notifier).state = 2,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
    );
  }
}
