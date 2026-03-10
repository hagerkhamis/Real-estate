import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/home/presentation/providers/home_providers.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/property_card.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/category_item.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertiesAsync = ref.watch(filteredPropertiesProvider);
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);


    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(propertiesFutureProvider.future),
          color: AppColors.primary,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                _buildHeader(context),
                SizedBox(height: 24.h),
                _buildSearchBar(context, ref),
                SizedBox(height: 24.h),

                _buildSectionHeader('التصنيفات', () => context.push('/all-categories')),
                SizedBox(height: 12.h),
                _buildCategories(ref, categories, selectedCategory),

                SizedBox(height: 24.h),
                propertiesAsync.when(
                  data: (properties) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('عقارات مميزة', () => context.push('/all-properties', extra: 'عقارات مميزة')),

                      SizedBox(height: 16.h),
                      _buildHorizontalList(properties),
                      SizedBox(height: 24.h),
                      _buildSectionHeader('عقارات مختارة', () => context.push('/all-properties', extra: 'عقارات مختارة')),

                      SizedBox(height: 16.h),
                      _buildVerticalList(properties),
                    ],
                  ),
                  loading: () => _buildLoadingState(),
                  error: (e, st) => _buildErrorState(e),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => context.push('/profile'),
              child: CircleAvatar(
                radius: 24.r,
                backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1974&auto=format&fit=crop'),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أهلاً بك مجدداً،',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
                ),
                Text(
                  'أحمد حسن',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            _buildHeaderIconButton(Icons.search, () {}),
            SizedBox(width: 10.w),
            _buildHeaderIconButton(Icons.notifications_outlined, () => context.push('/notifications')),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Icon(icon, color: Colors.white, size: 22.sp),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, WidgetRef ref) {
    return Container(
      height: 55.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.primary, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
              style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'ابحث عن عقارك المفضل...',
                hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14.sp),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _showFilterBottomSheet(context),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune, color: Colors.black, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final priceRange = ref.watch(priceRangeProvider);
          final minBedrooms = ref.watch(bedroomsProvider);
          final areaRange = ref.watch(areaRangeProvider);

          return Container(
            padding: EdgeInsets.all(24.w),
            height: MediaQuery.of(context).size.height * 0.7,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: AppColors.divider,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'خيارات الفلترة',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  
                  // Price Range Filter
                  _buildFilterSection(
                    context,
                    'نطاق السعر',
                    Icons.attach_money,
                    '${NumberFormat.compact().format(priceRange.start)} - ${NumberFormat.compact().format(priceRange.end)}',
                    Column(
                      children: [
                        RangeSlider(
                          values: priceRange,
                          min: 0,
                          max: 20000000,
                          divisions: 100,
                          activeColor: AppColors.primary,
                          onChanged: (values) => ref.read(priceRangeProvider.notifier).state = values,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('0', style: TextStyle(color: AppColors.textGrey, fontSize: 12.sp)),
                            Text('20M', style: TextStyle(color: AppColors.textGrey, fontSize: 12.sp)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // Bedrooms Filter
                  _buildFilterSection(
                    context,
                    'عدد الغرف',
                    Icons.bed,
                    minBedrooms == 0 ? 'الكل' : '$minBedrooms+ غرف',
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [0, 1, 2, 3, 4, 5].map((count) {
                        final isSelected = minBedrooms == count;
                        return GestureDetector(
                          onTap: () => ref.read(bedroomsProvider.notifier).state = count,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : AppColors.cardBg,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: isSelected ? Colors.transparent : AppColors.divider),
                            ),
                            child: Text(
                              count == 0 ? 'الكل' : count.toString(),
                              style: TextStyle(
                                color: isSelected ? Colors.black : AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // Area Filter
                  _buildFilterSection(
                    context,
                    'المساحة',
                    Icons.square_foot,
                    '${areaRange.start.round()} - ${areaRange.end.round()} م²',
                    Column(
                      children: [
                        RangeSlider(
                          values: areaRange,
                          min: 0,
                          max: 1000,
                          divisions: 50,
                          activeColor: AppColors.primary,
                          onChanged: (values) => ref.read(areaRangeProvider.notifier).state = values,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('0 م²', style: TextStyle(color: AppColors.textGrey, fontSize: 12.sp)),
                            Text('1000 م²', style: TextStyle(color: AppColors.textGrey, fontSize: 12.sp)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 40.h),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'تطبيق الفلترة',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, String title, IconData icon, String value, Widget child) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                value,
                style: TextStyle(color: AppColors.primary, fontSize: 14.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }



  Widget _buildCategories(WidgetRef ref, List<String> categories, String selectedCategory) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) => CategoryItem(
          label: _translateCategory(categories[index]),
          isSelected: categories[index] == selectedCategory,
          onTap: () => ref.read(selectedCategoryProvider.notifier).state = categories[index],
        ),
      ),
    );
  }


  String _translateCategory(String category) {
    switch (category) {
      case 'All': return 'الكل';
      case 'Apartment': return 'شقق';
      case 'Villa': return 'فلل';
      case 'Office': return 'مكاتب';
      case 'Studio': return 'ستوديو';
      case 'Penthouse': return 'بنتهاوس';
      default: return category;
    }
  }


  Widget _buildHorizontalList(List<dynamic> properties) {
    return SizedBox(
      height: 290.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: properties.length,
        clipBehavior: Clip.none,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) => PropertyCard(
          property: properties[index],
          isHorizontal: true,
        ),
      ),
    );
  }

  Widget _buildVerticalList(List<dynamic> properties) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: properties.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) => PropertyCard(
        property: properties[index],
        isHorizontal: false,
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: Text(
            'عرض الكل',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: EdgeInsets.only(top: 50.h),
      child: const Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  Widget _buildErrorState(dynamic error) {
    return Center(child: Text('حدث خطأ ما: $error', style: const TextStyle(color: Colors.red)));
  }
}
