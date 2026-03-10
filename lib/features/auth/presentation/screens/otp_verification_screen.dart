import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class OtpVerificationScreen extends StatefulWidget {
  final bool isEmail;
  final String contact;

  const OtpVerificationScreen({
    super.key,
    required this.isEmail,
    required this.contact,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _verifyOtp() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 6) {
      // هنا يمكن إضافة التحقق من الكود
      // في حالة النجاح، الانتقال إلى صفحة إعادة تعيين كلمة المرور
      context.push('/reset-password');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('الرجاء إدخال الرمز كاملاً'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _resendOtp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.isEmail
              ? 'تم إعادة إرسال الرمز إلى بريدك الإلكتروني'
              : 'تم إعادة إرسال الرمز إلى رقم هاتفك',
        ),
        backgroundColor: AppColors.success,
      ),
    );
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
              SizedBox(height: 20.h),
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.isEmail ? Icons.email_outlined : Icons.phone_outlined,
                    size: 50.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Center(
                child: Text(
                  'التحقق من الرمز',
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
                  widget.isEmail
                      ? 'أدخل الرمز المرسل إلى\n${widget.contact}'
                      : 'أدخل الرمز المرسل إلى\n${widget.contact}',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 48.h),
              
              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => _buildOtpField(index),
                ),
              ),
              
              SizedBox(height: 40.h),
              
              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: _verifyOtp,
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
                    'تحقق',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Resend OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لم تستلم الرمز؟ ',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: _resendOtp,
                    child: Text(
                      'إعادة الإرسال',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 50.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _otpControllers[index].text.isNotEmpty
              ? AppColors.primary
              : AppColors.divider,
          width: 2,
        ),
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            _onOtpChanged(index, value);
          });
        },
      ),
    );
  }
}
