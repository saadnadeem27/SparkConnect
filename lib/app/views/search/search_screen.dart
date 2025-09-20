import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_constants.dart';
import '../../widgets/custom_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Static data for demonstration
  final List<Map<String, dynamic>> staticUsers = [
    {
      'id': 'user1',
      'username': 'john_doe',
      'displayName': 'John Doe',
      'profileImage':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'isVerified': true,
      'followersCount': 12500,
      'bio': 'Fitness enthusiast & lifestyle blogger',
      'isFollowing': false,
    },
    {
      'id': 'user2',
      'username': 'sarah_photography',
      'displayName': 'Sarah Wilson',
      'profileImage':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'isVerified': false,
      'followersCount': 8900,
      'bio': 'Photographer | Capturing life\'s moments',
      'isFollowing': true,
    },
    {
      'id': 'user3',
      'username': 'tech_explorer',
      'displayName': 'Alex Chen',
      'profileImage':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      'isVerified': true,
      'followersCount': 25600,
      'bio': 'Software Developer | Tech Reviews',
      'isFollowing': false,
    },
  ];

  final List<String> staticHashtags = [
    '#fitness',
    '#photography',
    '#technology',
    '#food',
    '#travel',
    '#lifestyle',
    '#motivation',
    '#coding',
    '#nature',
    '#art',
  ];

  final List<Map<String, dynamic>> staticTrendingPosts = [
    {
      'id': 'trending1',
      'imageUrl':
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop',
      'likesCount': 1234,
      'commentsCount': 56,
    },
    {
      'id': 'trending2',
      'imageUrl':
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=300&fit=crop',
      'likesCount': 2847,
      'commentsCount': 89,
    },
    {
      'id': 'trending3',
      'imageUrl':
          'https://images.unsplash.com/photo-1555774698-0b77e0d5fac6?w=300&h=300&fit=crop',
      'likesCount': 891,
      'commentsCount': 34,
    },
    {
      'id': 'trending4',
      'imageUrl':
          'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=300&h=300&fit=crop',
      'likesCount': 567,
      'commentsCount': 78,
    },
    {
      'id': 'trending5',
      'imageUrl':
          'https://images.unsplash.com/photo-1542038784456-1ea8e935640e?w=300&h=300&fit=crop',
      'likesCount': 1567,
      'commentsCount': 123,
    },
    {
      'id': 'trending6',
      'imageUrl':
          'https://images.unsplash.com/photo-1506629905930-b0c00eddc6b4?w=300&h=300&fit=crop',
      'likesCount': 892,
      'commentsCount': 45,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: 70,
              title: SizedBox(
                height: 45,
                child: CustomTextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  hintText: 'Search users, hashtags...',
                  prefixIcon: Icons.search,
                  keyboardType: TextInputType.text,
                ),
              ),
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
                  Tab(text: 'People'),
                  Tab(text: 'Tags'),
                  Tab(text: 'Posts'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // People Tab
            _buildPeopleTab(),

            // Tags Tab
            _buildTagsTab(),

            // Posts Tab
            _buildPostsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeopleTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: staticUsers.length,
      itemBuilder: (context, index) {
        final user = staticUsers[index];

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
              GestureDetector(
                onTap: () {
                  Get.toNamed('/user-profile', arguments: user);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient:
                        user['isVerified'] ? AppColors.primaryGradient : null,
                    border: user['isVerified']
                        ? null
                        : Border.all(color: AppColors.borderColor, width: 2),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user['profileImage']),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/user-profile', arguments: user);
                  },
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
                        ],
                      ),
                      Text(
                        '@${user['username']}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['bio'],
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_formatCount(user['followersCount'])} followers',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  setState(() {
                    user['isFollowing'] = !user['isFollowing'];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient:
                        user['isFollowing'] ? null : AppColors.primaryGradient,
                    color: user['isFollowing'] ? AppColors.surfaceColor : null,
                    borderRadius: BorderRadius.circular(20),
                    border: user['isFollowing']
                        ? Border.all(color: AppColors.borderColor)
                        : null,
                  ),
                  child: Text(
                    user['isFollowing'] ? 'Following' : 'Follow',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: user['isFollowing']
                          ? AppColors.textPrimary
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTagsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.defaultPadding,
        mainAxisSpacing: AppConstants.defaultPadding,
        childAspectRatio: 3,
      ),
      itemCount: staticHashtags.length,
      itemBuilder: (context, index) {
        final hashtag = staticHashtags[index];

        return GestureDetector(
          onTap: () {
            Get.toNamed('/hashtag', arguments: hashtag);
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultBorderRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                hashtag,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: staticTrendingPosts.length,
      itemBuilder: (context, index) {
        final post = staticTrendingPosts[index];

        return GestureDetector(
          onTap: () {
            Get.toNamed('/post-detail', arguments: post);
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    post['imageUrl'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),

              // Overlay with stats
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        _formatCount(post['likesCount']),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
