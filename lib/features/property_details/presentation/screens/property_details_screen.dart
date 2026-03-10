import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/home/domain/entities/property.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(),
                  SizedBox(height: 24.h),
                  _buildQuickStats(),
                  SizedBox(height: 32.h),
                  _buildAgentSection(),
                  SizedBox(height: 32.h),
                  _buildDescriptionSection(),
                  SizedBox(height: 32.h),
                  _buildFeaturesSection(),
                  SizedBox(height: 100.h), // Space for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomBar(),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400.h,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl: property.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Text(
            property.type == 'Villa' ? 'فيلا فاخرة' : 'شقة عصرية',
            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12.sp),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          property.title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.location_on, color: AppColors.primary, size: 16.sp),
            SizedBox(width: 4.w),
            Text(
              property.address,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statItem(Icons.bed, '${property.bedrooms}', 'غرف نوم'),
        _statItem(Icons.bathtub, '${property.bathrooms}', 'حمامات'),
        _statItem(Icons.square_foot, '${property.area}', 'متر مربع'),
      ],
    );
  }

  Widget _statItem(IconData icon, String value, String label) {
    return Container(
      width: 105.w,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=1974&auto=format&fit=crop'),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ديفيد ميلر',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  'خبير عقاري سينيور',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _agentContactIcon(Icons.phone),
              SizedBox(width: 10.w),
              _agentContactIcon(Icons.message),
            ],
          ),
        ],
      ),
    );
  }

  Widget _agentContactIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.primary, size: 20.sp),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الوصف',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        Text(
          'تتميز هذه العقار بتصميم عصري وأنيق مع إطلالات خلابة ومساحات واسعة. تقع في منطقة هادئة وراقية وتوفر كافة سبل الراحة والرفاهية.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp, height: 1.6),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المميزات',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            _featureChip('مسبح'),
            _featureChip('نادي رياضي'),
            _featureChip('موقف سيارات'),
            _featureChip('أمن 24/7'),
            _featureChip('حديقة'),
          ],
        ),
      ],
    );
  }

  Widget _featureChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: AppColors.primary, size: 16.sp),
          SizedBox(width: 8.w),
          Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp)),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'السعر الإجمالي',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
              ),
              Text(
                NumberFormat.simpleCurrency(name: r'$', decimalDigits: 0).format(property.price),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: 30.w),
          Expanded(
            child: Container(
              height: 56.h,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'احجز الآن',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
