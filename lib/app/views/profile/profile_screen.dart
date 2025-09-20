import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_constants.dart';
import '../../controllers/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final AuthController authController = Get.find<AuthController>();

  // Mock current user data
  final Map<String, dynamic> currentUser = {
    'id': 'current_user',
    'username': 'your_username',
    'displayName': 'Your Name',
    'bio':
        'Living life one post at a time ✨\nPhotographer & Content Creator\n📍 New York, NY',
    'profileImage':
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop&crop=face',
    'coverImage':
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&h=300&fit=crop',
    'isVerified': false,
    'postsCount': 128,
    'followersCount': 12500,
    'followingCount': 892,
    'website': 'www.yourwebsite.com',
    'joinedDate': DateTime(2023, 1, 15),
  };

  final List<Map<String, dynamic>> userPosts = [
    {
      'id': '1',
      'imageUrl':
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop',
      'likesCount': 1234,
      'commentsCount': 56,
    },
    {
      'id': '2',
      'imageUrl':
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=300&fit=crop',
      'likesCount': 2847,
      'commentsCount': 89,
    },
    {
      'id': '3',
      'imageUrl':
          'https://images.unsplash.com/photo-1555774698-0b77e0d5fac6?w=300&h=300&fit=crop',
      'likesCount': 891,
      'commentsCount': 34,
    },
    {
      'id': '4',
      'imageUrl':
          'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=300&h=300&fit=crop',
      'likesCount': 567,
      'commentsCount': 78,
    },
    {
      'id': '5',
      'imageUrl':
          'https://images.unsplash.com/photo-1542038784456-1ea8e935640e?w=300&h=300&fit=crop',
      'likesCount': 1567,
      'commentsCount': 123,
    },
    {
      'id': '6',
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
            // App Bar
            SliverAppBar(
              expandedHeight: 100,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.white,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
              ),
              title: Text(
                currentUser['displayName'],
                style: AppTextStyles.h4.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit_profile',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('Edit Profile'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'settings',
                      child: Row(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(width: 8),
                          Text('Settings'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 8),
                          Text('Logout'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit_profile') {
                      Get.toNamed('/edit-profile');
                    } else if (value == 'settings') {
                      Get.toNamed('/settings');
                    } else if (value == 'logout') {
                      _showLogoutDialog();
                    }
                  },
                ),
              ],
            ),

            // Profile Header
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Cover Image & Profile Picture
                    Stack(
                      clipBehavior: Clip.none, // Allow overflow for profile image
                      children: [
                        // Cover Image
                        Container(
                          height: 180, // Increased height for better proportion
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(currentUser['coverImage']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Profile Picture with improved positioning
                        Positioned(
                          bottom: -60, // Adjusted for better overlap
                          left: MediaQuery.of(context).size.width * 0.05, // Responsive positioning
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 5), // Thicker border
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 6),
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 60, // Larger radius for better visibility
                              backgroundColor: Colors.grey[300], // Fallback color
                              child: ClipOval(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  child: Image.network(
                                    currentUser['profileImage'],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.grey[300]!,
                                              Colors.grey[400]!,
                                            ],
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey[600],
                                        ),
                                      );
                                    },
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.grey[200]!,
                                              Colors.grey[300]!,
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                                : null,
                                            strokeWidth: 3,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Edit Cover Button
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                // Handle cover image edit
                                _showImageOptionsDialog('cover');
                              },
                            ),
                          ),
                        ),

                        // Edit Profile Picture Button
                        Positioned(
                          bottom: -40,
                          left: MediaQuery.of(context).size.width * 0.05 + 80, // Responsive positioning over profile image
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                              onPressed: () {
                                // Handle profile image edit
                                _showImageOptionsDialog('profile');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 80), // Increased spacing to accommodate larger profile image

                    // User Info with fade-in animation
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 600),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.defaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    currentUser['displayName'],
                                    style: AppTextStyles.h3.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                if (currentUser['isVerified']) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.verified,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ],
                            ),

                          const SizedBox(height: 4),

                          Text(
                            '@${currentUser['username']}',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            currentUser['bio'],
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Stats Row
                          Row(
                            children: [
                              _buildStatItem(
                                  'Posts', currentUser['postsCount']),
                              const SizedBox(width: 24),
                              GestureDetector(
                                onTap: () => Get.toNamed('/followers'),
                                child: _buildStatItem(
                                    'Followers', currentUser['followersCount']),
                              ),
                              const SizedBox(width: 24),
                              GestureDetector(
                                onTap: () => Get.toNamed('/following'),
                                child: _buildStatItem(
                                    'Following', currentUser['followingCount']),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Get.toNamed('/edit-profile'),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                      gradient: AppColors.primaryGradient,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Text(
                                      'Edit Profile',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => Get.toNamed('/settings'),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Icon(
                                    Icons.settings_outlined,
                                    color: AppColors.textPrimary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ), // Close Padding
                    ), // Close AnimatedOpacity
                  ],
                ),
              ),
            ),

            // Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
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
                    Tab(icon: Icon(Icons.grid_on), text: 'Posts'),
                    Tab(icon: Icon(Icons.bookmark_border), text: 'Saved'),
                    Tab(icon: Icon(Icons.tag), text: 'Tagged'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Posts Tab
            _buildPostsGrid(userPosts),

            // Saved Tab
            _buildPostsGrid(userPosts.take(3).toList()),

            // Tagged Tab
            _buildPostsGrid(userPosts.take(2).toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formatCount(count),
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildPostsGrid(List<Map<String, dynamic>> posts) {
    if (posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No posts yet',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

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

  void _showImageOptionsDialog(String imageType) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Change ${imageType == 'profile' ? 'Profile Picture' : 'Cover Photo'}',
              style: AppTextStyles.h4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: AppColors.primaryColor,
                ),
              ),
              title: const Text('Take Photo'),
              onTap: () {
                Get.back();
                // Handle camera functionality
                Get.snackbar(
                  'Camera',
                  'Camera functionality would open here',
                  backgroundColor: AppColors.primaryColor,
                  colorText: Colors.white,
                );
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.photo_library,
                  color: AppColors.secondaryColor,
                ),
              ),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                // Handle gallery functionality
                Get.snackbar(
                  'Gallery',
                  'Gallery functionality would open here',
                  backgroundColor: AppColors.secondaryColor,
                  colorText: Colors.white,
                );
              },
            ),
            if (imageType == 'profile') ...[
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                title: const Text('Remove Photo'),
                onTap: () {
                  Get.back();
                  // Handle remove functionality
                  Get.snackbar(
                    'Removed',
                    'Profile picture removed',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                },
              ),
            ],
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Logout',
          style: AppTextStyles.h4.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              authController.signOut();
            },
            child: Text(
              'Logout',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
