/// User model for SparkConnect
class UserModel {
  final String id;
  final String email;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final String? bio;
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final bool isVerified;
  final bool isPrivate;
  final bool? isOnline;
  final DateTime? lastSeen;
  final DateTime? dateOfBirth;
  final String? location;
  final String? website;
  final String? phoneNumber;
  final bool emailVerified;
  final bool phoneVerified;
  final bool twoFactorEnabled;
  final bool pushNotificationsEnabled;
  final bool emailNotificationsEnabled;
  final bool darkModeEnabled;
  final String languageCode;
  final String? timeZone;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    this.bio,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
    this.isVerified = false,
    this.isPrivate = false,
    this.isOnline,
    this.lastSeen,
    this.dateOfBirth,
    this.location,
    this.website,
    this.phoneNumber,
    this.emailVerified = false,
    this.phoneVerified = false,
    this.twoFactorEnabled = false,
    this.pushNotificationsEnabled = true,
    this.emailNotificationsEnabled = true,
    this.darkModeEnabled = false,
    this.languageCode = 'en',
    this.timeZone,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      displayName: json['display_name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      followersCount: json['followers_count'] as int? ?? 0,
      followingCount: json['following_count'] as int? ?? 0,
      postsCount: json['posts_count'] as int? ?? 0,
      isVerified: json['is_verified'] as bool? ?? false,
      isPrivate: json['is_private'] as bool? ?? false,
      isOnline: json['is_online'] as bool?,
      lastSeen: json['last_seen'] != null
          ? DateTime.parse(json['last_seen'] as String)
          : null,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      location: json['location'] as String?,
      website: json['website'] as String?,
      phoneNumber: json['phone_number'] as String?,
      emailVerified: json['email_verified'] as bool? ?? false,
      phoneVerified: json['phone_verified'] as bool? ?? false,
      twoFactorEnabled: json['two_factor_enabled'] as bool? ?? false,
      pushNotificationsEnabled:
          json['push_notifications_enabled'] as bool? ?? true,
      emailNotificationsEnabled:
          json['email_notifications_enabled'] as bool? ?? true,
      darkModeEnabled: json['dark_mode_enabled'] as bool? ?? false,
      languageCode: json['language_code'] as String? ?? 'en',
      timeZone: json['time_zone'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'bio': bio,
      'followers_count': followersCount,
      'following_count': followingCount,
      'posts_count': postsCount,
      'is_verified': isVerified,
      'is_private': isPrivate,
      'is_online': isOnline,
      'last_seen': lastSeen?.toIso8601String(),
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'location': location,
      'website': website,
      'phone_number': phoneNumber,
      'email_verified': emailVerified,
      'phone_verified': phoneVerified,
      'two_factor_enabled': twoFactorEnabled,
      'push_notifications_enabled': pushNotificationsEnabled,
      'email_notifications_enabled': emailNotificationsEnabled,
      'dark_mode_enabled': darkModeEnabled,
      'language_code': languageCode,
      'time_zone': timeZone,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create a copy of UserModel with updated fields
  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? displayName,
    String? avatarUrl,
    String? bio,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    bool? isVerified,
    bool? isPrivate,
    bool? isOnline,
    DateTime? lastSeen,
    DateTime? dateOfBirth,
    String? location,
    String? website,
    String? phoneNumber,
    bool? emailVerified,
    bool? phoneVerified,
    bool? twoFactorEnabled,
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? darkModeEnabled,
    String? languageCode,
    String? timeZone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postsCount: postsCount ?? this.postsCount,
      isVerified: isVerified ?? this.isVerified,
      isPrivate: isPrivate ?? this.isPrivate,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      location: location ?? this.location,
      website: website ?? this.website,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      emailNotificationsEnabled:
          emailNotificationsEnabled ?? this.emailNotificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      languageCode: languageCode ?? this.languageCode,
      timeZone: timeZone ?? this.timeZone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Get user's age from date of birth
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    final age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      return age - 1;
    }
    return age;
  }

  /// Check if user is active (online within last 15 minutes)
  bool get isActive {
    if (isOnline == true) return true;
    if (lastSeen == null) return false;
    return DateTime.now().difference(lastSeen!).inMinutes <= 15;
  }

  /// Get formatted follower count
  String get formattedFollowersCount {
    if (followersCount < 1000) return followersCount.toString();
    if (followersCount < 1000000) {
      return '${(followersCount / 1000).toStringAsFixed(1)}K';
    }
    return '${(followersCount / 1000000).toStringAsFixed(1)}M';
  }

  /// Get formatted following count
  String get formattedFollowingCount {
    if (followingCount < 1000) return followingCount.toString();
    if (followingCount < 1000000) {
      return '${(followingCount / 1000).toStringAsFixed(1)}K';
    }
    return '${(followingCount / 1000000).toStringAsFixed(1)}M';
  }

  /// Get formatted posts count
  String get formattedPostsCount {
    if (postsCount < 1000) return postsCount.toString();
    if (postsCount < 1000000) {
      return '${(postsCount / 1000).toStringAsFixed(1)}K';
    }
    return '${(postsCount / 1000000).toStringAsFixed(1)}M';
  }

  /// Get initials for avatar placeholder
  String get initials {
    final names = displayName.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return displayName.length >= 2
        ? displayName.substring(0, 2).toUpperCase()
        : displayName.toUpperCase();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, displayName: $displayName)';
  }
}
