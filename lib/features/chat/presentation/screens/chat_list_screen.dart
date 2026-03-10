import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 10,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) => _buildChatItem(),
      ),
    );
  }

  Widget _buildChatItem() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1974&auto=format&fit=crop'),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 12.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                ),
              ),
            ],
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
                      'Michael Jordan',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '12:45 PM',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Is the modern villa still available for viewing tomorrow?',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
