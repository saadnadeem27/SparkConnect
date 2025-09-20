import 'user_model.dart';
import 'post_model.dart';

/// Enum for notification types
enum NotificationType {
  like,
  comment,
  follow,
  mention,
  share,
  story,
  message,
  system,
}

/// Notification model for SparkConnect
class NotificationModel {
  final String id;
  final String userId;
  final String? fromUserId;
  final NotificationType type;
  final String title;
  final String message;
  final String? postId;
  final String? storyId;
  final String? conversationId;
  final bool isRead;
  final Map<String, dynamic>? data;
  final DateTime createdAt;
  final UserModel? fromUser;
  final PostModel? post;

  const NotificationModel({
    required this.id,
    required this.userId,
    this.fromUserId,
    required this.type,
    required this.title,
    required this.message,
    this.postId,
    this.storyId,
    this.conversationId,
    this.isRead = false,
    this.data,
    required this.createdAt,
    this.fromUser,
    this.post,
  });

  /// Create NotificationModel from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      fromUserId: json['from_user_id'] as String?,
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.system,
      ),
      title: json['title'] as String,
      message: json['message'] as String,
      postId: json['post_id'] as String?,
      storyId: json['story_id'] as String?,
      conversationId: json['conversation_id'] as String?,
      isRead: json['is_read'] as bool? ?? false,
      data: json['data'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      fromUser: json['from_user'] != null
          ? UserModel.fromJson(json['from_user'] as Map<String, dynamic>)
          : null,
      post: json['post'] != null
          ? PostModel.fromJson(json['post'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Convert NotificationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'from_user_id': fromUserId,
      'type': type.name,
      'title': title,
      'message': message,
      'post_id': postId,
      'story_id': storyId,
      'conversation_id': conversationId,
      'is_read': isRead,
      'data': data,
      'created_at': createdAt.toIso8601String(),
      if (fromUser != null) 'from_user': fromUser!.toJson(),
      if (post != null) 'post': post!.toJson(),
    };
  }

  /// Create a copy of NotificationModel with updated fields
  NotificationModel copyWith({
    String? id,
    String? userId,
    String? fromUserId,
    NotificationType? type,
    String? title,
    String? message,
    String? postId,
    String? storyId,
    String? conversationId,
    bool? isRead,
    Map<String, dynamic>? data,
    DateTime? createdAt,
    UserModel? fromUser,
    PostModel? post,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fromUserId: fromUserId ?? this.fromUserId,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      postId: postId ?? this.postId,
      storyId: storyId ?? this.storyId,
      conversationId: conversationId ?? this.conversationId,
      isRead: isRead ?? this.isRead,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      fromUser: fromUser ?? this.fromUser,
      post: post ?? this.post,
    );
  }

  /// Get notification icon based on type
  String get icon {
    switch (type) {
      case NotificationType.like:
        return '❤️';
      case NotificationType.comment:
        return '💬';
      case NotificationType.follow:
        return '👤';
      case NotificationType.mention:
        return '@';
      case NotificationType.share:
        return '🔄';
      case NotificationType.story:
        return '📖';
      case NotificationType.message:
        return '💌';
      case NotificationType.system:
        return '🔔';
    }
  }

  /// Get notification color based on type
  String get colorHex {
    switch (type) {
      case NotificationType.like:
        return '#E53E3E'; // Red
      case NotificationType.comment:
        return '#3182CE'; // Blue
      case NotificationType.follow:
        return '#38A169'; // Green
      case NotificationType.mention:
        return '#D69E2E'; // Yellow
      case NotificationType.share:
        return '#805AD5'; // Purple
      case NotificationType.story:
        return '#DD6B20'; // Orange
      case NotificationType.message:
        return '#319795'; // Teal
      case NotificationType.system:
        return '#718096'; // Gray
    }
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

  /// Check if notification is recent (less than 24 hours)
  bool get isRecent {
    final difference = DateTime.now().difference(createdAt);
    return difference.inHours < 24;
  }

  /// Check if notification is actionable
  bool get isActionable {
    return [
      NotificationType.like,
      NotificationType.comment,
      NotificationType.follow,
      NotificationType.mention,
      NotificationType.message,
    ].contains(type);
  }

  /// Get notification priority
  int get priority {
    switch (type) {
      case NotificationType.message:
        return 3; // High
      case NotificationType.follow:
      case NotificationType.mention:
        return 2; // Medium
      case NotificationType.like:
      case NotificationType.comment:
      case NotificationType.share:
        return 1; // Low
      case NotificationType.story:
      case NotificationType.system:
        return 0; // Lowest
    }
  }

  /// Get formatted notification message with user names
  String get formattedMessage {
    if (fromUser != null) {
      return message.replaceAll('{username}', fromUser!.displayName);
    }
    return message;
  }

  /// Check if notification should show avatar
  bool get shouldShowAvatar =>
      fromUser != null && type != NotificationType.system;

  /// Check if notification can be dismissed
  bool get canDismiss => type != NotificationType.system;

  /// Check if notification requires action
  bool get requiresAction {
    switch (type) {
      case NotificationType.follow:
        return data?['requires_approval'] == true;
      case NotificationType.message:
        return !isRead;
      default:
        return false;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NotificationModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'NotificationModel(id: $id, type: $type, isRead: $isRead)';
  }
}
