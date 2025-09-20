import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Mock conversations data
  final List<Map<String, dynamic>> conversations = [
    {
      'id': 'conv1',
      'user': {
        'username': 'sarah_wilson',
        'fullName': 'Sarah Wilson',
        'profileImage': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
        'isOnline': true,
      },
      'lastMessage': {
        'text': 'Hey! How was your day? 😊',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
        'isRead': false,
        'isFromMe': false,
      },
      'unreadCount': 2,
    },
    {
      'id': 'conv2',
      'user': {
        'username': 'mike_chen',
        'fullName': 'Mike Chen',
        'profileImage': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        'isOnline': false,
      },
      'lastMessage': {
        'text': 'Thanks for the help yesterday!',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'isRead': true,
        'isFromMe': true,
      },
      'unreadCount': 0,
    },
    {
      'id': 'conv3',
      'user': {
        'username': 'emma_davis',
        'fullName': 'Emma Davis',
        'profileImage': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        'isOnline': true,
      },
      'lastMessage': {
        'text': 'Can\'t wait for the weekend!',
        'timestamp': DateTime.now().subtract(const Duration(hours: 4)),
        'isRead': true,
        'isFromMe': false,
      },
      'unreadCount': 0,
    },
    {
      'id': 'conv4',
      'user': {
        'username': 'alex_turner',
        'fullName': 'Alex Turner',
        'profileImage': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        'isOnline': false,
      },
      'lastMessage': {
        'text': 'Check out this cool photo I took!',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
        'isRead': true,
        'isFromMe': false,
      },
      'unreadCount': 0,
    },
    {
      'id': 'conv5',
      'user': {
        'username': 'lisa_brown',
        'fullName': 'Lisa Brown',
        'profileImage': 'https://images.unsplash.com/photo-1544725176-7c40e5a71c5e?w=150&h=150&fit=crop&crop=face',
        'isOnline': true,
      },
      'lastMessage': {
        'text': 'Great post about your trip!',
        'timestamp': DateTime.now().subtract(const Duration(days: 2)),
        'isRead': true,
        'isFromMe': false,
      },
      'unreadCount': 0,
    },
  ];

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${(difference.inDays / 7).floor()}w';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Messages',
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle new message
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.edit,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search messages...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.grey[600],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[600],
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          
          // Online Users
          Container(
            height: 90,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: conversations.where((c) => c['user']['isOnline']).length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your Story',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                final onlineUsers = conversations.where((c) => c['user']['isOnline']).toList();
                final user = onlineUsers[index - 1]['user'];
                
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(user['profileImage']),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['username'].length > 8 
                            ? '${user['username'].substring(0, 8)}...'
                            : user['username'],
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Conversations List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                final user = conversation['user'];
                final lastMessage = conversation['lastMessage'];
                final unreadCount = conversation['unreadCount'];
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(user['profileImage']),
                        ),
                        if (user['isOnline'])
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      user['fullName'],
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      lastMessage['text'],
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: unreadCount > 0 ? Colors.black87 : Colors.grey[600],
                        fontWeight: unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatTimestamp(lastMessage['timestamp']),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: unreadCount > 0 ? AppColors.primary : Colors.grey[600],
                            fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        if (unreadCount > 0) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              unreadCount.toString(),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    onTap: () {
                      Get.toNamed('/chat', arguments: conversation);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}