import 'package:get/get.dart';
import '../views/home/home_screen.dart';
import '../views/search/search_screen.dart';
import '../views/create_post/create_post_screen.dart';
import '../views/notifications/notifications_screen.dart';
import '../views/profile/profile_screen.dart';
import '../views/messages/messages_screen.dart';
import '../views/messages/chat_screen.dart';
import '../views/stories/story_viewer_screen.dart';
import '../views/settings/settings_screen.dart';
import '../views/main_navigation_screen.dart';

/// Application routes for navigation
class AppRoutes {
  // Main navigation
  static const String initial = '/';

  // Authentication routes
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Main app routes
  static const String home = '/home';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String createPost = '/create-post';
  static const String postDetails = '/post-details';
  static const String userProfile = '/user-profile';

  // Stories routes
  static const String stories = '/stories';
  static const String createStory = '/create-story';
  static const String storyViewer = '/story-viewer';

  // Messaging routes
  static const String messages = '/messages';
  static const String chat = '/chat';
  static const String newMessage = '/new-message';

  // Search and explore routes
  static const String search = '/search';
  static const String explore = '/explore';
  static const String hashtag = '/hashtag';

  // Notifications route
  static const String notifications = '/notifications';

  // Settings routes
  static const String settings = '/settings';
  static const String accountSettings = '/account-settings';
  static const String privacySettings = '/privacy-settings';
  static const String notificationSettings = '/notification-settings';
  static const String securitySettings = '/security-settings';

  // Follow routes
  static const String followers = '/followers';
  static const String following = '/following';

  // Other routes
  static const String webView = '/webview';
  static const String imageViewer = '/image-viewer';
  static const String videoPlayer = '/video-player';

  // GetX Routes
  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const MainNavigationScreen(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: search,
      page: () => const SearchScreen(),
    ),
    GetPage(
      name: createPost,
      page: () => const CreatePostScreen(),
    ),
    GetPage(
      name: notifications,
      page: () => const NotificationsScreen(),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: messages,
      page: () => const MessagesScreen(),
    ),
    GetPage(
      name: chat,
      page: () => const ChatScreen(),
    ),
    GetPage(
      name: storyViewer,
      page: () => const StoryViewerScreen(),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsScreen(),
    ),
  ];
}
