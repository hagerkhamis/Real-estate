import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class AgentProfileScreen extends StatelessWidget {
  const AgentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildAgentHeader(),
            SizedBox(height: 24.h),
            _buildContactButtons(),
            SizedBox(height: 32.h),
            _buildAgentAbout(),
            SizedBox(height: 32.h),
            _buildAgentListings(),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=1974&auto=format&fit=crop'),
        ),
        SizedBox(height: 16.h),
        Text(
          'David Miller',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.h),
        Text(
          'Senior Real Estate Expert • 8yrs exp',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.orange, size: 18),
            SizedBox(width: 4.w),
            Text(
              '4.9 (124 reviews)',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactButtons() {
    return Row(
      children: [
        Expanded(child: _buildIconButton(Icons.phone, 'Call', Colors.blue)),
        SizedBox(width: 15.w),
        Expanded(child: _buildIconButton(Icons.message, 'Message', AppColors.primary)),
        SizedBox(width: 15.w),
        Expanded(child: _buildIconButton(Icons.email, 'Email', Colors.white)),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22.sp),
          SizedBox(height: 4.h),
          Text(label, style: TextStyle(color: AppColors.textPrimary, fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildAgentAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About David',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        Text(
          'David Miller is one of the most trusted agents in New Cairo, specializing in luxury villas and high-end apartments. With over 8 years of experience, he helps clients find their dream homes with professional guidance.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildAgentListings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'David\'s Listings (12)',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              'See All',
              style: TextStyle(color: AppColors.primary, fontSize: 14.sp),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        // Mock list of properties
        const SizedBox(
          height: 100,
          child: Center(child: Text('Listing Cards Placeholder', style: TextStyle(color: Colors.white70))),
        ),
      ],
    );
  }
}
