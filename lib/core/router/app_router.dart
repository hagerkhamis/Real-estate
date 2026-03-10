import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:flutter_application_1/features/home/presentation/screens/main_layout.dart';
import 'package:flutter_application_1/features/property_details/presentation/screens/property_details_screen.dart';
import 'package:flutter_application_1/features/home/domain/entities/property.dart';
import 'package:flutter_application_1/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:flutter_application_1/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:flutter_application_1/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:flutter_application_1/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter_application_1/features/profile/presentation/screens/agent_profile_screen.dart';
import 'package:flutter_application_1/features/profile/presentation/screens/my_properties_screen.dart';
import 'package:flutter_application_1/features/profile/presentation/screens/reviews_screen.dart';
import 'package:flutter_application_1/features/home/presentation/screens/all_properties_screen.dart';
import 'package:flutter_application_1/features/home/presentation/screens/all_categories_screen.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/reset_password_screen.dart';



final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const MainLayout(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/otp-verification',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return OtpVerificationScreen(
            isEmail: extra['isEmail'] as bool,
            contact: extra['contact'] as String,
          );
        },
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => const ResetPasswordScreen(),
      ),

      GoRoute(
        path: '/details',
        builder: (context, state) {
          final property = state.extra as Property;
          return PropertyDetailsScreen(property: property);
        },
      ),
      GoRoute(
        path: '/chats',
        builder: (context, state) => const ChatListScreen(),
      ),
      GoRoute(
        path: '/chat-details',
        builder: (context, state) => const ChatDetailsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/agent-profile',
        builder: (context, state) => const AgentProfileScreen(),
      ),
      GoRoute(
        path: '/my-properties',
        builder: (context, state) => const MyPropertiesScreen(),
      ),
      GoRoute(
        path: '/reviews',
        builder: (context, state) => const ReviewsScreen(),
      ),
      GoRoute(
        path: '/all-properties',
        builder: (context, state) {
          final title = state.extra as String? ?? 'كل العقارات';
          return AllPropertiesScreen(title: title);
        },
      ),
      GoRoute(
        path: '/all-categories',
        builder: (context, state) => const AllCategoriesScreen(),
      ),

    ],
  );
}
