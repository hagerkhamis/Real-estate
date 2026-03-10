import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'أدخل بياناتك للبدء معنا',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                  ),
                ),
              ),

              SizedBox(height: 32.h),
              _buildTextField(
                label: 'الاسم الكامل',
                controller: _nameController,
                hint: 'أدخل اسمك بالكامل',
                icon: Icons.person_outline,
              ),
              SizedBox(height: 20.h),
              _buildTextField(
                label: 'البريد الإلكتروني',
                controller: _emailController,
                hint: 'أدخل بريدك الإلكتروني',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),
              _buildTextField(
                label: 'رقم الهاتف',
                controller: _phoneController,
                hint: 'أدخل رقم هاتفك',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20.h),
              _buildTextField(
                label: 'كلمة المرور',
                controller: _passwordController,
                hint: 'أدخل كلمة المرور',
                icon: Icons.lock_outline,
                isPassword: true,
                isPasswordVisible: _isPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              SizedBox(height: 20.h),
              _buildTextField(
                label: 'تأكيد كلمة المرور',
                controller: _confirmPasswordController,
                hint: 'أعد إدخال كلمة المرور',
                icon: Icons.lock_reset_outlined,
                isPassword: true,
                isPasswordVisible: _isPasswordVisible,
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () => context.go('/'),
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
                    'تسجيل',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لديك حساب بالفعل؟ ',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
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
    TextInputType? keyboardType,
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
            keyboardType: keyboardType,
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
