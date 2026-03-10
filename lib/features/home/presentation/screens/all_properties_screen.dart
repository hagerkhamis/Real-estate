import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/home/presentation/providers/home_providers.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/property_card.dart';
import 'package:go_router/go_router.dart';

class AllPropertiesScreen extends ConsumerWidget {
  final String title;
  const AllPropertiesScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertiesAsync = ref.watch(propertiesFutureProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: propertiesAsync.when(
        data: (properties) => ListView.separated(
          padding: EdgeInsets.all(20.w),
          itemCount: properties.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) => PropertyCard(
            property: properties[index],
            isHorizontal: false,
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text('حدث خطأ ما: $e', style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}
