import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60.h),
            _buildProfileHeader(),
            SizedBox(height: 32.h),
            _buildProfileStats(context),
            SizedBox(height: 32.h),
            _buildProfileMenu(context),
            SizedBox(height: 32.h),
            _buildLogoutButton(context),
            SizedBox(height: 40.h),

          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1974&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.black, size: 20),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'أحمد حسن',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'ahmed.hassan@example.com',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildProfileStats(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(context, 'عقاراتي', '12', '/my-properties'),
          _buildStatItem(context, 'المحفوظة', '24', '/'), // Tab 3 index is saved
          _buildStatItem(context, 'تقييماتي', '4.9', '/reviews'),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, String route) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          _buildMenuItem(context, Icons.person_outline, 'المعلومات الشخصية', () {}),
          _buildDivider(),
          _buildMenuItem(context, Icons.home_work_outlined, 'إدارة العقارات', () => context.push('/my-properties')),
          _buildDivider(),
          _buildMenuItem(context, Icons.notifications_outlined, 'الإشعارات', () => context.push('/notifications')),
          _buildDivider(),
          _buildMenuItem(context, Icons.chat_bubble_outline, 'الرسائل', () => context.push('/chats')),
          _buildDivider(),
          _buildMenuItem(context, Icons.settings_outlined, 'الإعدادات', () => context.push('/settings')),
          _buildDivider(),
          _buildMenuItem(context, Icons.help_outline, 'مركز المساعدة', () {}),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 24.sp),
      title: Text(
        title,
        style: TextStyle(color: AppColors.textPrimary, fontSize: 15.sp),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textGrey, size: 16.sp),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.divider, height: 1, indent: 50.w);
  }

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/login'),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        height: 55.h,
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.logout, color: AppColors.error),
              SizedBox(width: 8.w),
              Text(
                'تسجيل الخروج',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

