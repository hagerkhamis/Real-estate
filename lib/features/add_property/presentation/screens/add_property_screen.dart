import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Property',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: _buildStepContent(),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
      child: Row(
        children: List.generate(3, (index) {
          final isCompleted = _currentStep > index;
          final isCurrent = _currentStep == index;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: isCompleted || isCurrent ? AppColors.primary : AppColors.divider,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted 
                      ? const Icon(Icons.check, color: Colors.black, size: 18)
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isCurrent ? Colors.black : AppColors.textGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                ),
                if (index < 2)
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: isCompleted ? AppColors.primary : AppColors.divider,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0: return _buildGeneralInfo();
      case 1: return _buildPhotosAndPricing();
      case 2: return _buildLocationAndMore();
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildGeneralInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Property Title', 'e.g. Modern Villa with Pool'),
        SizedBox(height: 20.h),
        _buildDropdownField('Property Type', 'Apartment'),
        SizedBox(height: 20.h),
        _buildTextField('Description', 'Tell us more about your property...', maxLines: 5),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(child: _buildTextField('Bedrooms', '3', keyboardType: TextInputType.number)),
            SizedBox(width: 15.w),
            Expanded(child: _buildTextField('Bathrooms', '2', keyboardType: TextInputType.number)),
          ],
        ),
      ],
    );
  }

  Widget _buildPhotosAndPricing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Photos',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          height: 150.h,
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider, style: BorderStyle.solid),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload_outlined, color: AppColors.primary, size: 40.sp),
              SizedBox(height: 8.h),
              Text('Tap to upload images', style: TextStyle(color: AppColors.textGrey)),
            ],
          ),
        ),
        SizedBox(height: 30.h),
        _buildTextField('Price', 'e.g. \$1,200,000', keyboardType: TextInputType.number),
        SizedBox(height: 20.h),
        _buildTextField('Area (m²)', 'e.g. 250', keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildLocationAndMore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Address', 'Full address of the property'),
        SizedBox(height: 20.h),
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: AppColors.primary, size: 30.sp),
                SizedBox(height: 8.h),
                Text('Select Location on Map', style: TextStyle(color: AppColors.textGrey)),
              ],
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Text(
          'Amenities',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            _buildAmenityChip('Swimming Pool'),
            _buildAmenityChip('Gym'),
            _buildAmenityChip('Parking'),
            _buildAmenityChip('Security'),
            _buildAmenityChip('Garden'),
          ],
        ),
      ],
    );
  }

  Widget _buildAmenityChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp)),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        TextField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 55.h,
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: TextStyle(color: Colors.white)),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
            ],
          ),
        ),
      ],
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
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _currentStep--),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Back', style: TextStyle(color: AppColors.primary)),
              ),
            ),
          if (_currentStep > 0) SizedBox(width: 15.w),
          Expanded(
            child: Container(
              height: 56.h,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentStep < 2) {
                    setState(() => _currentStep++);
                  } else {
                    // Submit
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  _currentStep < 2 ? 'Next Step' : 'Publish Property',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
