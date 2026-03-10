import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isEmailSelected = true;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'نسيت كلمة المرور؟',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  'اختر طريقة استعادة كلمة المرور الخاصة بك',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.h),
              
              // Selection Tabs
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isEmailSelected = true),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            gradient: _isEmailSelected ? AppColors.primaryGradient : null,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: _isEmailSelected ? Colors.black : AppColors.textGrey,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'البريد',
                                style: TextStyle(
                                  color: _isEmailSelected ? Colors.black : AppColors.textGrey,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isEmailSelected = false),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            gradient: !_isEmailSelected ? AppColors.primaryGradient : null,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                color: !_isEmailSelected ? Colors.black : AppColors.textGrey,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'الهاتف',
                                style: TextStyle(
                                  color: !_isEmailSelected ? Colors.black : AppColors.textGrey,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 32.h),
              
              // Input Field
              if (_isEmailSelected) ...[
                Text(
                  'البريد الإلكتروني',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp),
                    decoration: InputDecoration(
                      hintText: 'أدخل بريدك الإلكتروني',
                      hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14.sp),
                      prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    ),
                  ),
                ),
              ] else ...[
                Text(
                  'رقم الهاتف',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp),
                    decoration: InputDecoration(
                      hintText: 'أدخل رقم هاتفك',
                      hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14.sp),
                      prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    ),
                  ),
                ),
              ],
              
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    final contact = _isEmailSelected
                        ? _emailController.text
                        : _phoneController.text;
                    
                    if (contact.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isEmailSelected
                              ? 'الرجاء إدخال البريد الإلكتروني'
                              : 'الرجاء إدخال رقم الهاتف'),
                          backgroundColor: AppColors.error,
                        ),
                      );
                      return;
                    }
                    
                    // الانتقال إلى صفحة OTP
                    context.push(
                      '/otp-verification',
                      extra: {
                        'isEmail': _isEmailSelected,
                        'contact': contact,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    shadowColor: AppColors.primary.withValues(alpha: 0.3),
                  ),
                  child: Text(
                    _isEmailSelected ? 'إرسال الرابط' : 'إرسال الرمز',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

