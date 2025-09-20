import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Static notification data
  final List<Map<String, dynamic>> staticNotifications = [
    {
      'id': '1',
      'type': 'like',
      'user': {
        'id': 'user1',
        'username': 'john_doe',
        'displayName': 'John Doe',
        'profileImage':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        'isVerified': true,
      },
      'message': 'liked your post',
      'postThumbnail':
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=150&h=150&fit=crop',
      'createdAt': DateTime.now().subtract(const Duration(minutes: 30)),
      'isRead': false,
    },
    {
      'id': '2',
      'type': 'follow',
      'user': {
        'id': 'user2',
        'username': 'sarah_photography',
        'displayName': 'Sarah Wilson',
        'profileImage':
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        'isVerified': false,
      },
      'message': 'started following you',
      'createdAt': DateTime.now().subtract(const Duration(hours: 1)),
      'isRead': false,
    },
    {
      'id': '3',
      'type': 'comment',
      'user': {
        'id': 'user3',
        'username': 'tech_explorer',
        'displayName': 'Alex Chen',
        'profileImage':
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        'isVerified': true,
      },
      'message': 'commented on your post: "Amazing work! Keep it up 🔥"',
      'postThumbnail':
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=150&h=150&fit=crop',
      'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': true,
    },
    {
      'id': '4',
      'type': 'mention',
      'user': {
        'id': 'user4',
        'username': 'foodie_adventures',
        'displayName': 'Emma Rodriguez',
        'profileImage':
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        'isVerified': false,
      },
      'message': 'mentioned you in a post',
      'postThumbnail':
          'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=150&h=150&fit=crop',
      'createdAt': DateTime.now().subtract(const Duration(hours: 4)),
      'isRead': true,
    },
    {
      'id': '5',
      'type': 'like',
      'user': {
        'id': 'user5',
        'username': 'travel_lover',
        'displayName': 'Mike Johnson',
        'profileImage':
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
        'isVerified': false,
      },
      'message': 'liked your story',
      'createdAt': DateTime.now().subtract(const Duration(hours: 6)),
      'isRead': true,
    },
  ];

  final List<Map<String, dynamic>> staticActivities = [
    {
      'id': '1',
      'type': 'post_performance',
      'message': 'Your post received 1.2K likes today!',
      'icon': Icons.trending_up,
      'color': AppColors.successColor,
      'createdAt': DateTime.now().subtract(const Duration(hours: 1)),
    },
    {
      'id': '2',
      'type': 'milestone',
      'message': 'Congratulations! You reached 10K followers 🎉',
      'icon': Icons.emoji_events,
      'color': AppColors.primaryColor,
      'createdAt': DateTime.now().subtract(const Duration(hours: 8)),
    },
    {
      'id': '3',
      'type': 'reminder',
      'message': 'Don\'t forget to share your story today',
      'icon': Icons.notifications_outlined,
      'color': AppColors.infoColor,
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'like':
        return Icons.favorite;
      case 'comment':
        return Icons.chat_bubble;
      case 'follow':
        return Icons.person_add;
      case 'mention':
        return Icons.alternate_email;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationIconColor(String type) {
    switch (type) {
      case 'like':
        return AppColors.likeColor;
      case 'comment':
        return AppColors.primaryColor;
      case 'follow':
        return AppColors.successColor;
      case 'mention':
        return AppColors.infoColor;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: AppTextStyles.h4.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.textPrimary,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'mark_all_read',
                child: Row(
                  children: [
                    Icon(Icons.done_all),
                    SizedBox(width: 8),
                    Text('Mark all as read'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 8),
                    Text('Notification settings'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'mark_all_read') {
                setState(() {
                  for (var notification in staticNotifications) {
                    notification['isRead'] = true;
                  }
                });
                Get.snackbar(
                  'Done',
                  'All notifications marked as read',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.successColor,
                  colorText: Colors.white,
                );
              } else if (value == 'settings') {
                Get.toNamed('/notification-settings');
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primaryColor,
          indicatorWeight: 3,
          labelStyle: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTextStyles.bodyMedium,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Activity'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All Notifications Tab
          _buildAllNotificationsTab(),

          // Activity Tab
          _buildActivityTab(),
        ],
      ),
    );
  }

  Widget _buildAllNotificationsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: staticNotifications.length,
      itemBuilder: (context, index) {
        final notification = staticNotifications[index];
        final user = notification['user'] as Map<String, dynamic>;

        return GestureDetector(
          onTap: () {
            setState(() {
              notification['isRead'] = true;
            });

            // Navigate based on notification type
            if (notification['type'] == 'follow') {
              Get.toNamed('/user-profile', arguments: user);
            } else if (notification['postThumbnail'] != null) {
              Get.toNamed('/post-detail', arguments: notification);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            decoration: BoxDecoration(
              color: notification['isRead']
                  ? Colors.white
                  : AppColors.primaryColor.withOpacity(0.05),
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultBorderRadius),
              border: notification['isRead']
                  ? Border.all(color: AppColors.borderColor.withOpacity(0.5))
                  : Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Avatar with notification icon
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(user['profileImage']),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              _getNotificationIconColor(notification['type']),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          _getNotificationIcon(notification['type']),
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                // Notification content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user['displayName'],
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (user['isVerified']) ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified,
                              color: AppColors.primaryColor,
                              size: 16,
                            ),
                          ],
                          const Spacer(),
                          if (!notification['isRead'])
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        notification['message'],
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timeago.format(notification['createdAt']),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Post thumbnail (if available)
                if (notification['postThumbnail'] != null) ...[
                  const SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      notification['postThumbnail'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActivityTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: staticActivities.length,
      itemBuilder: (context, index) {
        final activity = staticActivities[index];

        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(AppConstants.defaultBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Activity Icon
              Container(
                decoration: BoxDecoration(
                  color: activity['color'].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  activity['icon'],
                  color: activity['color'],
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // Activity content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['message'],
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      timeago.format(activity['createdAt']),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
