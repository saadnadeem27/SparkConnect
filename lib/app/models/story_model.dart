import 'user_model.dart';

/// Enum for story types
enum StoryType {
  image,
  video,
  text,
}

/// Story model for SparkConnect
class StoryModel {
  final String id;
  final String userId;
  final String? content;
  final String? imageUrl;
  final String? videoUrl;
  final String? backgroundColor;
  final String? textColor;
  final String? fontStyle;
  final int viewsCount;
  final bool isViewed;
  final bool isOwn;
  final List<String>? viewers;
  final Duration? duration;
  final DateTime createdAt;
  final DateTime expiresAt;
  final UserModel? user;

  const StoryModel({
    required this.id,
    required this.userId,
    this.content,
    this.imageUrl,
    this.videoUrl,
    this.backgroundColor,
    this.textColor,
    this.fontStyle,
    this.viewsCount = 0,
    this.isViewed = false,
    this.isOwn = false,
    this.viewers,
    this.duration,
    required this.createdAt,
    required this.expiresAt,
    this.user,
  });

  /// Create StoryModel from JSON
  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String?,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      backgroundColor: json['background_color'] as String?,
      textColor: json['text_color'] as String?,
      fontStyle: json['font_style'] as String?,
      viewsCount: json['views_count'] as int? ?? 0,
      isViewed: json['is_viewed'] as bool? ?? false,
      isOwn: json['is_own'] as bool? ?? false,
      viewers: json['viewers'] != null 
          ? List<String>.from(json['viewers'] as List)
          : null,
      duration: json['duration'] != null 
          ? Duration(seconds: json['duration'] as int)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
      user: json['profiles'] != null 
          ? UserModel.fromJson(json['profiles'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Convert StoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'content': content,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'background_color': backgroundColor,
      'text_color': textColor,
      'font_style': fontStyle,
      'views_count': viewsCount,
      'is_viewed': isViewed,
      'is_own': isOwn,
      'viewers': viewers,
      'duration': duration?.inSeconds,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt.toIso8601String(),
      if (user != null) 'profiles': user!.toJson(),
    };
  }

  /// Create a copy of StoryModel with updated fields
  StoryModel copyWith({
    String? id,
    String? userId,
    String? content,
    String? imageUrl,
    String? videoUrl,
    String? backgroundColor,
    String? textColor,
    String? fontStyle,
    int? viewsCount,
    bool? isViewed,
    bool? isOwn,
    List<String>? viewers,
    Duration? duration,
    DateTime? createdAt,
    DateTime? expiresAt,
    UserModel? user,
  }) {
    return StoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      fontStyle: fontStyle ?? this.fontStyle,
      viewsCount: viewsCount ?? this.viewsCount,
      isViewed: isViewed ?? this.isViewed,
      isOwn: isOwn ?? this.isOwn,
      viewers: viewers ?? this.viewers,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      user: user ?? this.user,
    );
  }

  /// Get story type based on content
  StoryType get storyType {
    if (videoUrl != null) return StoryType.video;
    if (imageUrl != null) return StoryType.image;
    return StoryType.text;
  }

  /// Check if story has media content
  bool get hasMedia => storyType != StoryType.text;

  /// Check if story is expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Get remaining time until expiry
  Duration get remainingTime {
    if (isExpired) return Duration.zero;
    return expiresAt.difference(DateTime.now());
  }

  /// Get formatted remaining time
  String get formattedRemainingTime {
    if (isExpired) return 'Expired';
    
    final remaining = remainingTime;
    if (remaining.inHours > 0) {
      return '${remaining.inHours}h';
    } else if (remaining.inMinutes > 0) {
      return '${remaining.inMinutes}m';
    } else {
      return '${remaining.inSeconds}s';
    }
  }

  /// Get formatted views count
  String get formattedViewsCount {
    if (viewsCount < 1000) return viewsCount.toString();
    if (viewsCount < 1000000) {
      return '${(viewsCount / 1000).toStringAsFixed(1)}K';
    }
    return '${(viewsCount / 1000000).toStringAsFixed(1)}M';
  }

  /// Get time ago formatted string
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  /// Get default duration based on story type
  Duration get defaultDuration {
    switch (storyType) {
      case StoryType.video:
        return duration ?? const Duration(seconds: 15);
      case StoryType.image:
      case StoryType.text:
        return const Duration(seconds: 5);
    }
  }

  /// Check if story can be viewed
  bool get canView => !isExpired;

  /// Check if story can be deleted
  bool get canDelete => isOwn && !isExpired;

  /// Check if story can be replied to
  bool get canReply => !isExpired && !isOwn;

  /// Get story preview text
  String get previewText {
    if (content != null && content!.isNotEmpty) {
      return content!.length > 50 ? '${content!.substring(0, 50)}...' : content!;
    }
    switch (storyType) {
      case StoryType.image:
        return 'Photo';
      case StoryType.video:
        return 'Video';
      case StoryType.text:
        return 'Story';
    }
  }

  /// Check if user has viewed this story
  bool hasViewedBy(String userId) {
    return viewers?.contains(userId) ?? false;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StoryModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'StoryModel(id: $id, userId: $userId, type: $storyType)';
  }
}