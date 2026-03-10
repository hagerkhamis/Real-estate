import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('الرجاء ملء جميع الحقول'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('كلمة المرور غير متطابقة'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (newPassword.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('كلمة المرور يجب أن تكون 6 أحرف على الأقل'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // هنا يمكن إضافة منطق إعادة تعيين كلمة المرور
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم تغيير كلمة المرور بنجاح'),
        backgroundColor: AppColors.success,
      ),
    );

    // الانتقال إلى صفحة تسجيل الدخول
    context.go('/login');
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
        child: SingleChildScrollView(
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
                    Icons.lock_reset,
                    size: 50.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Center(
                child: Text(
                  'إعادة تعيين كلمة المرور',
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
                  'أدخل كلمة المرور الجديدة الخاصة بك',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 48.h),
              
              // New Password Field
              _buildTextField(
                label: 'كلمة المرور الجديدة',
                controller: _newPasswordController,
                hint: 'أدخل كلمة المرور الجديدة',
                icon: Icons.lock_outline,
                isPassword: true,
                isPasswordVisible: _isNewPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
              ),
              
              SizedBox(height: 20.h),
              
              // Confirm Password Field
              _buildTextField(
                label: 'تأكيد كلمة المرور',
                controller: _confirmPasswordController,
                hint: 'أعد إدخال كلمة المرور',
                icon: Icons.lock_reset_outlined,
                isPassword: true,
                isPasswordVisible: _isConfirmPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              
              SizedBox(height: 40.h),
              
              // Reset Password Button
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: _resetPassword,
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
                    'تأكيد',
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            controller: controller,
            obscureText: isPassword && !isPasswordVisible,
            style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14.sp),
              prefixIcon: Icon(icon, color: AppColors.primary),
              suffixIcon: isPassword && onToggleVisibility != null
                  ? IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textGrey,
                      ),
                      onPressed: onToggleVisibility,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
      ],
    );
  }
}
