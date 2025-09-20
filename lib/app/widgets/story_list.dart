import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_constants.dart';

class StoryList extends StatelessWidget {
  const StoryList({super.key});

  // Static story data
  static List<Map<String, dynamic>> get staticStories => [
    {
      'id': 'my_story',
      'user': {
        'id': 'current_user',
        'username': 'you',
        'displayName': 'Your Story',
        'profileImage': 'https://images.unsplash.com/photo-1494790108755-2616b612b0e5?w=150&h=150&fit=crop&crop=face',
      },
      'isMyStory': true,
      'hasStory': false,
      'isViewed': false,
    },
    {
      'id': 'story1',
      'user': {
        'id': 'user1',
        'username': 'john_doe',
        'displayName': 'John Doe',
        'profileImage': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      },
      'isMyStory': false,
      'hasStory': true,
      'isViewed': false,
      'thumbnail': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=400&fit=crop',
      'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'id': 'story2',
      'user': {
        'id': 'user2',
        'username': 'sarah_photography',
        'displayName': 'Sarah Wilson',
        'profileImage': 'https://images.unsplash.com/photo-1494790108755-2616b612b0e5?w=150&h=150&fit=crop&crop=face',
      },
      'isMyStory': false,
      'hasStory': true,
      'isViewed': true,
      'thumbnail': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=400&fit=crop',
      'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
    },
    {
      'id': 'story3',
      'user': {
        'id': 'user3',
        'username': 'tech_explorer',
        'displayName': 'Alex Chen',
        'profileImage': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      },
      'isMyStory': false,
      'hasStory': true,
      'isViewed': false,
      'thumbnail': 'https://images.unsplash.com/photo-1555774698-0b77e0d5fac6?w=300&h=400&fit=crop',
      'createdAt': DateTime.now().subtract(const Duration(hours: 8)),
    },
    {
      'id': 'story4',
      'user': {
        'id': 'user4',
        'username': 'foodie_adventures',
        'displayName': 'Emma Rodriguez',
        'profileImage': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      },
      'isMyStory': false,
      'hasStory': true,
      'isViewed': true,
      'thumbnail': 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=300&h=400&fit=crop',
      'createdAt': DateTime.now().subtract(const Duration(hours: 12)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
          scrollDirection: Axis.horizontal,
          itemCount: staticStories.length,
          itemBuilder: (context, index) {
            final story = staticStories[index];
            final user = story['user'] as Map<String, dynamic>;
            
            return GestureDetector(
              onTap: () {
                if (story['isMyStory'] && !story['hasStory']) {
                  // Navigate to create story
                  Get.toNamed('/create-story');
                } else {
                  // Navigate to view story
                  Get.toNamed('/story-viewer', arguments: story);
                }
              },
              child: Container(
                width: 70,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    // Story Circle
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: story['isMyStory'] && !story['hasStory']
                            ? null
                            : story['isViewed']
                                ? AppColors.viewedStoryGradient
                                : AppColors.storyGradient,
                        border: story['isMyStory'] && !story['hasStory']
                            ? Border.all(
                                color: AppColors.borderColor,
                                width: 2,
                              )
                            : null,
                      ),
                      padding: const EdgeInsets.all(3),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 26,
                              backgroundImage: NetworkImage(user['profileImage']),
                            ),
                          ),
                          if (story['isMyStory'] && !story['hasStory'])
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 6),
                    
                    // Username
                    Text(
                      story['isMyStory'] ? 'Your Story' : user['displayName'],
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}