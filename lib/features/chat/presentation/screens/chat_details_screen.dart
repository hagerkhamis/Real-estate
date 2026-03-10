import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1974&auto=format&fit=crop'),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Michael Jordan',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Online',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.success),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                _buildMessageBubble(true, 'Hello! I saw your villa in New Cairo.'),
                _buildMessageBubble(true, 'Is it still available?'),
                _buildMessageBubble(false, 'Yes, it is! Would you like to schedule a visit?'),
                _buildMessageBubble(true, 'Yes, how about tomorrow at 2 PM?'),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(bool isMe, String text) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : AppColors.cardBg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: isMe ? Colors.black : Colors.white, fontSize: 14.sp),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                suffixIcon: Icon(Icons.attach_file, color: AppColors.textGrey, size: 22.sp),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send, color: Colors.black, size: 24),
          ),
        ],
      ),
    );
  }
}
