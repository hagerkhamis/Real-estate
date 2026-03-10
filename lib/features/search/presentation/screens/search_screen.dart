import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RangeValues _priceRange = const RangeValues(100000, 5000000);
  int _selectedBedrooms = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property Type',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            _buildPropertyTypes(),
            SizedBox(height: 32.h),
            Text(
              'Price Range',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 10000000,
              divisions: 100,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.divider,
              labels: RangeLabels(
                '\$${(_priceRange.start / 1000).toStringAsFixed(0)}k',
                '\$${(_priceRange.end / 1000).toStringAsFixed(0)}k',
              ),
              onChanged: (values) {
                setState(() => _priceRange = values);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$0', style: TextStyle(color: AppColors.textGrey, fontSize: 12.sp)),
                Text('\$10M+', style: TextStyle(color: AppColors.textGrey, fontSize: 12.sp)),
              ],
            ),
            SizedBox(height: 32.h),
            Text(
              'Bedrooms',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            _buildBedroomSelector(),
            SizedBox(height: 32.h),
            _buildFilterOption('Location', 'Cairo, Egypt'),
            _buildFilterOption('Amenities', 'Pool, Gym, Parking'),
            SizedBox(height: 40.h),
            _buildApplyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyTypes() {
    final types = ['Any', 'Apartment', 'Villa', 'Office', 'Studio'];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: types.map((type) {
        final isSelected = type == 'Any';
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? null : Border.all(color: AppColors.divider),
          ),
          child: Text(
            type,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBedroomSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        final label = index == 0 ? 'Any' : index == 5 ? '5+' : '$index';
        final isSelected = _selectedBedrooms == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedBedrooms = index),
          child: Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: isSelected ? null : Border.all(color: AppColors.divider),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFilterOption(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: TextStyle(color: Colors.white)),
                Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Apply Filters',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
