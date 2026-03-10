import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقييمات'), // Reviews in Arabic
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildRatingSummary(),
          Divider(color: AppColors.divider, height: 40.h),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: 5,
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
              itemBuilder: (context, index) => _buildReviewItem(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                '4.9',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
              Row(
                children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.orange, size: 20)),
              ),
              SizedBox(height: 8.h),
              Text(
                '124 تقييم',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
              ),
            ],
          ),
          SizedBox(width: 40.w),
          Expanded(
            child: Column(
              children: [
                _ratingBar(5, 0.9),
                _ratingBar(4, 0.1),
                _ratingBar(3, 0.0),
                _ratingBar(2, 0.0),
                _ratingBar(1, 0.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBar(int star, double progress) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Text('$star', style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp)),
          SizedBox(width: 8.w),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4.h,
                backgroundColor: AppColors.divider,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1974&auto=format&fit=crop'),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ياسر محمد',
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'منذ يومين',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            Row(
              children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.orange, size: 14)),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          'تجربة رائعة جداً، الوكيل متعاون جداً والعقار كان مطابقاً تماماً للوصف والصور المعروضة. أنصح بالتعامل معه.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp, height: 1.5),
        ),
      ],
    );
  }
}
