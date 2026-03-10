import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/home/domain/entities/property.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/property_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock favorited properties
    final List<Property> savedProperties = [
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
        isFavorite: true,
      ),
      Property(
        id: '3',
        title: 'Ocean Breeze Penthouse',
        address: 'North Coast, Egypt',
        price: 8900000,
        imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=2070&auto=format&fit=crop',
        bedrooms: 4,
        bathrooms: 3,
        area: 320,
        type: 'Penthouse',
        isFavorite: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Properties',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: savedProperties.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: savedProperties.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) => PropertyCard(
                property: savedProperties[index],
                isHorizontal: false,
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80.sp, color: AppColors.divider),
          SizedBox(height: 16.h),
          Text(
            'No saved properties yet',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            'Keep track of properties you like',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
