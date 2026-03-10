import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Simulated Map Background
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF131826),
            child: Opacity(
              opacity: 0.3,
              child: Image.network(
                'https://api.mapbox.com/styles/v1/mapbox/dark-v10/static/-74.0060,40.7128,12,0/800x800?access_token=placeholder',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.map, color: AppColors.textGrey, size: 100.sp),
                ),
              ),
            ),
          ),
          
          // Custom Map Markers (Simulated)
          _buildMapMarker(200.h, 100.w, r'$2.4M'),
          _buildMapMarker(400.h, 250.w, r'$1.2M'),
          _buildMapMarker(150.h, 280.w, r'$3.8M'),
          _buildMapMarker(500.h, 120.w, r'$950k'),

          // Header Search Bar
          Positioned(
            top: 50.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 55.h,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: AppColors.primary, size: 22.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Search location...',
                    style: TextStyle(color: AppColors.textGrey, fontSize: 14.sp),
                  ),
                  const Spacer(),
                  Icon(Icons.tune, color: AppColors.textGrey, size: 22.sp),
                ],
              ),
            ),
          ),

          // Bottom Property Carousel (Horizontal List)
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 120.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) => SizedBox(width: 15.w),
                itemBuilder: (context, index) => _buildMapPropertyCard(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapMarker(double top, double left, String price) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Text(
          price,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildMapPropertyCard() {
    return Container(
      width: 280.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=2070&auto=format&fit=crop',
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Oceanic Villa',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'El Gouna, Hurghada',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text(
                  r'$1,450,000',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
