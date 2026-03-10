import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 8,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) => _buildNotificationItem(index),
      ),
    );
  }

  Widget _buildNotificationItem(int index) {
    final bool isNew = index < 2;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isNew ? AppColors.primary.withValues(alpha: 0.05) : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isNew ? AppColors.primary.withValues(alpha: 0.3) : AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: isNew ? AppColors.primary : AppColors.cardBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              index % 2 == 0 ? Icons.home_rounded : Icons.local_offer_rounded,
              color: isNew ? Colors.black : AppColors.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      index % 2 == 0 ? 'New Property Alert' : 'Price Drop!',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '2h ago',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 11.sp),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  index % 2 == 0 
                    ? 'A new villa matching your search was just posted in New Cairo.'
                    : 'A property on your saved list dropped its price by \$50,000.',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
