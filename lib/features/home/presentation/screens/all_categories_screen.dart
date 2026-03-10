import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/home/presentation/providers/home_providers.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/category_item.dart';
import 'package:go_router/go_router.dart';

class AllCategoriesScreen extends ConsumerWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'كل التصنيفات',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(20.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) => CategoryItem(
          label: _translateCategory(categories[index]),
          isSelected: false,
        ),
      ),
    );
  }

  String _translateCategory(String category) {
    switch (category) {
      case 'Apartment': return 'شقق';
      case 'Villa': return 'فلل';
      case 'Office': return 'مكاتب';
      case 'Studio': return 'ستوديو';
      case 'Penthouse': return 'بنتهاوس';
      default: return category;
    }
  }
}
