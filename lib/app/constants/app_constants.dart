/// App-wide constants for SparkConnect
class AppConstants {
  // App Info
  static const String appName = 'SparkConnect';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Connect, Share, Inspire';

  // Supabase Configuration
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // Storage Configuration
  static const String profileBucket = 'profiles';
  static const String postsBucket = 'posts';
  static const String storiesBucket = 'stories';
  static const String messagesBucket = 'messages';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;

  static const double defaultBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;
  static const double extraLargeBorderRadius = 24.0;

  static const double defaultElevation = 4.0;
  static const double smallElevation = 2.0;
  static const double largeElevation = 8.0;

  // Image Sizes
  static const double profileImageSize = 40.0;
  static const double largeProfileImageSize = 80.0;
  static const double storyImageSize = 60.0;
  static const double postImageMaxHeight = 400.0;

  // Posts Configuration
  static const int maxPostLength = 280;
  static const int maxHashtags = 10;
  static const int maxImagesPerPost = 4;
  static const int maxVideoSizeInMB = 50;

  // Stories Configuration
  static const Duration storyDuration = Duration(hours: 24);
  static const Duration storyViewDuration = Duration(seconds: 15);

  // Messages Configuration
  static const int maxMessageLength = 1000;
  static const int messagesPageSize = 50;

  // Network Configuration
  static const Duration networkTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;

  // Pagination
  static const int defaultPageSize = 20;
  static const int postsPageSize = 10;
  static const int usersPageSize = 15;

  // Validation
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 20;
  static const int minPasswordLength = 8;
  static const int maxBioLength = 150;

  // Deep Links
  static const String deepLinkScheme = 'sparkconnect';
  static const String sharePostUrl = 'sparkconnect.app/post/';
  static const String shareProfileUrl = 'sparkconnect.app/profile/';

  // Error Messages
  static const String networkErrorMessage = 'Network error. Please check your connection.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String unknownErrorMessage = 'Something went wrong. Please try again.';
  
  // Success Messages
  static const String postCreatedMessage = 'Post created successfully!';
  static const String profileUpdatedMessage = 'Profile updated successfully!';
  static const String followedUserMessage = 'You are now following this user!';
  static const String unfollowedUserMessage = 'You unfollowed this user.';
}