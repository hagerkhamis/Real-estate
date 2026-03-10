import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/home/domain/entities/property.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final bool isHorizontal;

  const PropertyCard({
    super.key,
    required this.property,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/details', extra: property),
      child: isHorizontal ? _buildHorizontalCard() : _buildVerticalCard(),
    );
  }

  Widget _buildHorizontalCard() {
    return Container(
      width: 280.w,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: CachedNetworkImage(
                  imageUrl: property.imageUrl,
                  height: 170.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: AppColors.divider),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.divider,
                    child: const Icon(Icons.broken_image, color: AppColors.textGrey),
                  ),

                ),
              ),
              Positioned(
                top: 15.h,
                right: 15.w,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    property.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: property.isFavorite ? Colors.red : Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
              Positioned(
                bottom: 15.h,
                left: 15.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _translateType(property.type),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.location_on, color: AppColors.primary, size: 14.sp),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        property.address,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      NumberFormat.compactSimpleCurrency(name: r'$').format(property.price),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        _infoIcon(Icons.bed, property.bedrooms.toString()),
                        SizedBox(width: 12.w),
                        _infoIcon(Icons.bathtub, property.bathrooms.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalCard() {
    return Container(
      height: 130.h,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
            child: CachedNetworkImage(
              imageUrl: property.imageUrl,
              width: 130.w,
              height: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                color: AppColors.divider,
                child: const Icon(Icons.broken_image, color: AppColors.textGrey),
              ),

            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.title,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.favorite_border, color: AppColors.textGrey, size: 18.sp),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    property.address,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NumberFormat.compactSimpleCurrency(name: r'$').format(property.price),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          _infoIcon(Icons.square_foot, '${property.area} م²'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoIcon(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 14.sp),
        SizedBox(width: 4.w),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  String _translateType(String type) {
    switch (type) {
      case 'Apartment': return 'شقة';
      case 'Villa': return 'فيلا';
      case 'Office': return 'مكتب';
      case 'Penthouse': return 'بنتهاوس';
      case 'Studio': return 'استوديو';
      default: return type;

    }
  }
}
