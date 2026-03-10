import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: AppColors.divider),
          gradient: isSelected ? AppColors.primaryGradient : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}

