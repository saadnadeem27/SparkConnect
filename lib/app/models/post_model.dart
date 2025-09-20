import 'user_model.dart';

/// Enum for post types
enum PostType {
  text,
  image,
  video,
  multiImage,
}

/// Post model for SparkConnect
class PostModel {
  final String id;
  final String userId;
  final String content;
  final List<String>? imageUrls;
  final String? videoUrl;
  final List<String>? hashtags;
  final List<String>? mentions;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isLiked;
  final bool isBookmarked;
  final String? location;
  final bool isEdited;
  final bool isPrivate;
  final bool commentsEnabled;
  final bool likesVisible;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel? user;

  const PostModel({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrls,
    this.videoUrl,
    this.hashtags,
    this.mentions,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.isLiked = false,
    this.isBookmarked = false,
    this.location,
    this.isEdited = false,
    this.isPrivate = false,
    this.commentsEnabled = true,
    this.likesVisible = true,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  /// Create PostModel from JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      imageUrls: json['image_urls'] != null 
          ? List<String>.from(json['image_urls'] as List)
          : null,
      videoUrl: json['video_url'] as String?,
      hashtags: json['hashtags'] != null 
          ? List<String>.from(json['hashtags'] as List)
          : null,
      mentions: json['mentions'] != null 
          ? List<String>.from(json['mentions'] as List)
          : null,
      likesCount: json['likes_count'] as int? ?? 0,
      commentsCount: json['comments_count'] as int? ?? 0,
      sharesCount: json['shares_count'] as int? ?? 0,
      isLiked: json['is_liked'] as bool? ?? false,
      isBookmarked: json['is_bookmarked'] as bool? ?? false,
      location: json['location'] as String?,
      isEdited: json['is_edited'] as bool? ?? false,
      isPrivate: json['is_private'] as bool? ?? false,
      commentsEnabled: json['comments_enabled'] as bool? ?? true,
      likesVisible: json['likes_visible'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      user: json['profiles'] != null 
          ? UserModel.fromJson(json['profiles'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Convert PostModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'content': content,
      'image_urls': imageUrls,
      'video_url': videoUrl,
      'hashtags': hashtags,
      'mentions': mentions,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'shares_count': sharesCount,
      'is_liked': isLiked,
      'is_bookmarked': isBookmarked,
      'location': location,
      'is_edited': isEdited,
      'is_private': isPrivate,
      'comments_enabled': commentsEnabled,
      'likes_visible': likesVisible,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      if (user != null) 'profiles': user!.toJson(),
    };
  }

  /// Create a copy of PostModel with updated fields
  PostModel copyWith({
    String? id,
    String? userId,
    String? content,
    List<String>? imageUrls,
    String? videoUrl,
    List<String>? hashtags,
    List<String>? mentions,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    bool? isLiked,
    bool? isBookmarked,
    String? location,
    bool? isEdited,
    bool? isPrivate,
    bool? commentsEnabled,
    bool? likesVisible,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? user,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      imageUrls: imageUrls ?? this.imageUrls,
      videoUrl: videoUrl ?? this.videoUrl,
      hashtags: hashtags ?? this.hashtags,
      mentions: mentions ?? this.mentions,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      location: location ?? this.location,
      isEdited: isEdited ?? this.isEdited,
      isPrivate: isPrivate ?? this.isPrivate,
      commentsEnabled: commentsEnabled ?? this.commentsEnabled,
      likesVisible: likesVisible ?? this.likesVisible,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }

  /// Get post type based on content
  PostType get postType {
    if (videoUrl != null) return PostType.video;
    if (imageUrls != null && imageUrls!.isNotEmpty) {
      return imageUrls!.length > 1 ? PostType.multiImage : PostType.image;
    }
    return PostType.text;
  }

  /// Check if post has media content
  bool get hasMedia => postType != PostType.text;

  /// Get formatted likes count
  String get formattedLikesCount {
    if (likesCount < 1000) return likesCount.toString();
    if (likesCount < 1000000) {
      return '${(likesCount / 1000).toStringAsFixed(1)}K';
    }
    return '${(likesCount / 1000000).toStringAsFixed(1)}M';
  }

  /// Get formatted comments count
  String get formattedCommentsCount {
    if (commentsCount < 1000) return commentsCount.toString();
    if (commentsCount < 1000000) {
      return '${(commentsCount / 1000).toStringAsFixed(1)}K';
    }
    return '${(commentsCount / 1000000).toStringAsFixed(1)}M';
  }

  /// Get formatted shares count
  String get formattedSharesCount {
    if (sharesCount < 1000) return sharesCount.toString();
    if (sharesCount < 1000000) {
      return '${(sharesCount / 1000).toStringAsFixed(1)}K';
    }
    return '${(sharesCount / 1000000).toStringAsFixed(1)}M';
  }

  /// Get time ago formatted string
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 7) {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  /// Extract hashtags from content
  List<String> get extractedHashtags {
    final regex = RegExp(r'#\w+');
    final matches = regex.allMatches(content);
    return matches.map((match) => match.group(0)!).toList();
  }

  /// Extract mentions from content
  List<String> get extractedMentions {
    final regex = RegExp(r'@\w+');
    final matches = regex.allMatches(content);
    return matches.map((match) => match.group(0)!).toList();
  }

  /// Get content with formatted hashtags and mentions
  String get formattedContent {
    String formatted = content;
    
    // Replace hashtags
    final hashtagRegex = RegExp(r'#\w+');
    formatted = formatted.replaceAllMapped(hashtagRegex, (match) {
      return match.group(0)!; // You can add styling here if needed
    });
    
    // Replace mentions
    final mentionRegex = RegExp(r'@\w+');
    formatted = formatted.replaceAllMapped(mentionRegex, (match) {
      return match.group(0)!; // You can add styling here if needed
    });
    
    return formatted;
  }

  /// Check if post content is long
  bool get isLongContent => content.length > 280;

  /// Get truncated content for preview
  String get truncatedContent {
    if (content.length <= 280) return content;
    return '${content.substring(0, 280)}...';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PostModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'PostModel(id: $id, userId: $userId, type: $postType)';
  }
}