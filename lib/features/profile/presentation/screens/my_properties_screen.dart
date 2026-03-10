import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/home/domain/entities/property.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/property_card.dart';

class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Property> myProperties = [
      Property(
        id: '1',
        title: 'Modern Luxury Villa',
        address: 'New Cairo, Egypt',
        price: 12500000,
        imageUrl: 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=2071&auto=format&fit=crop',
        bedrooms: 5,
        bathrooms: 4,
        area: 450,
        type: 'Villa',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('عقاراتي'), // My Properties in Arabic
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: myProperties.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: myProperties.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) => Stack(
                children: [
                   PropertyCard(
                    property: myProperties[index],
                    isHorizontal: false,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: PopupMenuButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      itemBuilder: (context) => [
                        const PopupMenuItem(child: Text('تعديل')),
                        const PopupMenuItem(child: Text('حذف')),
                        const PopupMenuItem(child: Text('إخفاء')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home_work_outlined, size: 80.sp, color: AppColors.divider),
          SizedBox(height: 16.h),
          Text(
            'لم تقم بإضافة عقارات بعد',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            'ابدأ بإضافة عقارك الأول الآن',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
