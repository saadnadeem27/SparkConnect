import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import 'home/home_screen.dart';
import 'search/search_screen.dart';
import 'create_post/create_post_screen.dart';
import 'notifications/notifications_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navController = Get.put(NavigationController());

    final List<Widget> pages = [
      const HomeScreen(),
      const SearchScreen(),
      const CreatePostScreen(),
      const NotificationsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: Obx(() => IndexedStack(
        index: navController.currentIndex,
        children: pages,
      )),
      bottomNavigationBar: Obx(() => Container(
        margin: const EdgeInsets.all(AppConstants.defaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: BottomNavigationBar(
              currentIndex: navController.currentIndex,
              onTap: navController.changePage,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.6),
              selectedFontSize: 12,
              unselectedFontSize: 10,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              items: [
                BottomNavigationBarItem(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.all(navController.currentIndex == 0 ? 8 : 4),
                    decoration: navController.currentIndex == 0
                        ? BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: Icon(
                      navController.currentIndex == 0 ? Icons.home : Icons.home_outlined,
                      size: navController.currentIndex == 0 ? 28 : 24,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.all(navController.currentIndex == 1 ? 8 : 4),
                    decoration: navController.currentIndex == 1
                        ? BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: Icon(
                      navController.currentIndex == 1 ? Icons.search : Icons.search_outlined,
                      size: navController.currentIndex == 1 ? 28 : 24,
                    ),
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.all(navController.currentIndex == 2 ? 8 : 4),
                    decoration: navController.currentIndex == 2
                        ? BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: Icon(
                      navController.currentIndex == 2 ? Icons.add_box : Icons.add_box_outlined,
                      size: navController.currentIndex == 2 ? 28 : 24,
                    ),
                  ),
                  label: 'Create',
                ),
                BottomNavigationBarItem(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.all(navController.currentIndex == 3 ? 8 : 4),
                    decoration: navController.currentIndex == 3
                        ? BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: Stack(
                      children: [
                        Icon(
                          navController.currentIndex == 3 ? Icons.notifications : Icons.notifications_outlined,
                          size: navController.currentIndex == 3 ? 28 : 24,
                        ),
                        // Notification badge
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: AppColors.errorColor,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: const Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.all(navController.currentIndex == 4 ? 8 : 4),
                    decoration: navController.currentIndex == 4
                        ? BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: CircleAvatar(
                      radius: navController.currentIndex == 4 ? 14 : 12,
                      backgroundColor: Colors.white,
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1494790108755-2616b612b0e5?w=150&h=150&fit=crop&crop=face',
                      ),
                      child: navController.currentIndex == 4
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}