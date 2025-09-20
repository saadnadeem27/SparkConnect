import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_constants.dart';
import '../../widgets/post_card.dart';
import '../../widgets/story_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  
  // Static data for demonstration
  final List<Map<String, dynamic>> staticPosts = [
    {
      'id': '1',
      'user': {
        'id': 'user1',
        'username': 'john_doe',
        'displayName': 'John Doe',
        'profileImage': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        'isVerified': true,
      },
      'content': 'Just finished an amazing workout! 💪 Feeling stronger every day. What\'s your fitness goal for this month? #fitness #motivation #workout',
      'imageUrl': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=600&h=400&fit=crop',
      'videoUrl': null,
      'likesCount': 1234,
      'commentsCount': 56,
      'sharesCount': 23,
      'isLiked': false,
      'isBookmarked': true,
      'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
      'hashtags': ['fitness', 'motivation', 'workout'],
    },
    {
      'id': '2',
      'user': {
        'id': 'user2',
        'username': 'sarah_photography',
        'displayName': 'Sarah Wilson',
        'profileImage': 'https://images.unsplash.com/photo-1494790108755-2616b612b0e5?w=150&h=150&fit=crop&crop=face',
        'isVerified': false,
      },
      'content': 'Golden hour magic ✨ There\'s something special about this time of day that makes everything look beautiful. Shot this during my evening walk in the park.',
      'imageUrl': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&h=400&fit=crop',
      'videoUrl': null,
      'likesCount': 2847,
      'commentsCount': 89,
      'sharesCount': 45,
      'isLiked': true,
      'isBookmarked': false,
      'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
      'hashtags': ['photography', 'goldenhour', 'nature'],
    },
    {
      'id': '3',
      'user': {
        'id': 'user3',
        'username': 'tech_explorer',
        'displayName': 'Alex Chen',
        'profileImage': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        'isVerified': true,
      },
      'content': 'Just released my new app! 🚀 It\'s been months of hard work, late nights, and countless cups of coffee. So excited to share it with the world! Link in bio.',
      'imageUrl': 'https://images.unsplash.com/photo-1555774698-0b77e0d5fac6?w=600&h=400&fit=crop',
      'videoUrl': null,
      'likesCount': 891,
      'commentsCount': 34,
      'sharesCount': 67,
      'isLiked': false,
      'isBookmarked': true,
      'createdAt': DateTime.now().subtract(const Duration(hours: 8)),
      'hashtags': ['app', 'launch', 'coding', 'developer'],
    },
    {
      'id': '4',
      'user': {
        'id': 'user4',
        'username': 'foodie_adventures',
        'displayName': 'Emma Rodriguez',
        'profileImage': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        'isVerified': false,
      },
      'content': 'Homemade pasta night! 🍝 Nothing beats fresh ingredients and a little love in the kitchen. Recipe in the comments!',
      'imageUrl': 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=600&h=400&fit=crop',
      'videoUrl': null,
      'likesCount': 567,
      'commentsCount': 78,
      'sharesCount': 12,
      'isLiked': true,
      'isBookmarked': false,
      'createdAt': DateTime.now().subtract(const Duration(hours: 12)),
      'hashtags': ['food', 'cooking', 'pasta', 'homemade'],
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 70,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
            ),
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white70],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'SparkConnect',
                    style: AppTextStyles.h3.copyWith(
                      background: Paint()
                        ..shader = AppColors.primaryGradient.createShader(
                          const Rect.fromLTWH(0, 0, 200, 70),
                        ),
                      color: Colors.transparent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // Navigate to messages
                  Get.toNamed('/messages');
                },
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          
          // Stories Section
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: const StoryList(),
            ),
          ),
          
          // Posts Feed
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = staticPosts[index];
                return PostCard(
                  post: post,
                  onLike: () {
                    setState(() {
                      post['isLiked'] = !post['isLiked'];
                      post['likesCount'] += post['isLiked'] ? 1 : -1;
                    });
                  },
                  onComment: () {
                    // Navigate to comments
                    Get.toNamed('/post-detail', arguments: post);
                  },
                  onShare: () {
                    // Handle share
                    Get.snackbar(
                      'Shared!',
                      'Post shared successfully',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.successColor,
                      colorText: Colors.white,
                    );
                  },
                  onBookmark: () {
                    setState(() {
                      post['isBookmarked'] = !post['isBookmarked'];
                    });
                  },
                  onProfileTap: () {
                    // Navigate to user profile
                    Get.toNamed('/user-profile', arguments: post['user']);
                  },
                );
              },
              childCount: staticPosts.length,
            ),
          ),
          
          // Bottom padding for navigation bar
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}