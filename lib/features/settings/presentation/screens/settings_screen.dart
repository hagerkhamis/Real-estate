import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildSettingsSection('App Settings', [
            _buildSettingsToggle('Dark Mode', true),
            _buildSettingsToggle('Push Notifications', true),
            _buildSettingsToggle('Email Notifications', false),
          ]),
          SizedBox(height: 24.h),
          _buildSettingsSection('Security', [
            _buildSettingsTile(Icons.lock_outline, 'Change Password'),
            _buildSettingsTile(Icons.face_unlock_outlined, 'Face ID / Bio Login'),
            _buildSettingsTile(Icons.verified_user_outlined, 'Two-Factor Authentication'),
          ]),
          SizedBox(height: 24.h),
          _buildSettingsSection('Other', [
            _buildSettingsTile(Icons.language, 'Language', trailingText: 'English'),
            _buildSettingsTile(Icons.info_outline, 'Version', trailingText: '1.0.2'),
            _buildSettingsTile(Icons.delete_outline, 'Delete Account', isDestructive: true),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
          child: Text(
            title,
            style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsToggle(String title, bool value) {
    return ListTile(
      title: Text(title, style: TextStyle(color: AppColors.textPrimary, fontSize: 15.sp)),
      trailing: Switch(
        value: value,
        onChanged: (val) {},
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, {String? trailingText, bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? AppColors.error : AppColors.primary, size: 24.sp),
      title: Text(
        title,
        style: TextStyle(color: isDestructive ? AppColors.error : AppColors.textPrimary, fontSize: 15.sp),
      ),
      trailing: trailingText != null 
        ? Text(trailingText, style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp))
        : Icon(Icons.arrow_forward_ios, color: AppColors.textGrey, size: 16.sp),
      onTap: () {},
    );
  }
}
