import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(height: 40.h),
              Center(
                child: Image.asset(
                  AppAssets.logo,
                  width: 150.w,
                  height: 150.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 40.h),
              Center(
                child: Text(
                  'تسجيل الدخول',
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
                  'قم بتسجيل الدخول للمتابعة',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                  ),
                ),
              ),

              SizedBox(height: 40.h),
              _buildTextField(
                label: 'البريد الإلكتروني',
                controller: _emailController,
                hint: 'أدخل بريدك الإلكتروني',
                icon: Icons.email_outlined,
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
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push('/forgot-password'),
                  child: Text(
                    'هل نسيت كلمة المرور؟',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
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
                    'دخول',
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
                    'ليس لديك حساب؟ ',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/register'),
                    child: Text(
                      'تسجيل جديد',
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
              suffixIcon: isPassword
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
