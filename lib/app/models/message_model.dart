import 'user_model.dart';

/// Enum for message types
enum MessageType {
  text,
  image,
  video,
  audio,
  file,
  location,
  story,
  post,
}

/// Enum for message status
enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}

/// Message model for SparkConnect
class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String? recipientId;
  final String? content;
  final String? attachmentUrl;
  final String? attachmentType;
  final int? attachmentSize;
  final String? thumbnailUrl;
  final MessageType type;
  final MessageStatus status;
  final String? replyToMessageId;
  final bool isEdited;
  final bool isDeleted;
  final bool isForwarded;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? readAt;
  final DateTime? deliveredAt;
  final UserModel? sender;
  final MessageModel? replyToMessage;

  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    this.recipientId,
    this.content,
    this.attachmentUrl,
    this.attachmentType,
    this.attachmentSize,
    this.thumbnailUrl,
    this.type = MessageType.text,
    this.status = MessageStatus.sending,
    this.replyToMessageId,
    this.isEdited = false,
    this.isDeleted = false,
    this.isForwarded = false,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.readAt,
    this.deliveredAt,
    this.sender,
    this.replyToMessage,
  });

  /// Create MessageModel from JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      senderId: json['sender_id'] as String,
      recipientId: json['recipient_id'] as String?,
      content: json['content'] as String?,
      attachmentUrl: json['attachment_url'] as String?,
      attachmentType: json['attachment_type'] as String?,
      attachmentSize: json['attachment_size'] as int?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),
      status: MessageStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => MessageStatus.sent,
      ),
      replyToMessageId: json['reply_to_message_id'] as String?,
      isEdited: json['is_edited'] as bool? ?? false,
      isDeleted: json['is_deleted'] as bool? ?? false,
      isForwarded: json['is_forwarded'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      readAt: json['read_at'] != null
          ? DateTime.parse(json['read_at'] as String)
          : null,
      deliveredAt: json['delivered_at'] != null
          ? DateTime.parse(json['delivered_at'] as String)
          : null,
      sender: json['sender'] != null
          ? UserModel.fromJson(json['sender'] as Map<String, dynamic>)
          : null,
      replyToMessage: json['reply_to_message'] != null
          ? MessageModel.fromJson(
              json['reply_to_message'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Convert MessageModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'recipient_id': recipientId,
      'content': content,
      'attachment_url': attachmentUrl,
      'attachment_type': attachmentType,
      'attachment_size': attachmentSize,
      'thumbnail_url': thumbnailUrl,
      'type': type.name,
      'status': status.name,
      'reply_to_message_id': replyToMessageId,
      'is_edited': isEdited,
      'is_deleted': isDeleted,
      'is_forwarded': isForwarded,
      'metadata': metadata,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'read_at': readAt?.toIso8601String(),
      'delivered_at': deliveredAt?.toIso8601String(),
      if (sender != null) 'sender': sender!.toJson(),
      if (replyToMessage != null) 'reply_to_message': replyToMessage!.toJson(),
    };
  }

  /// Create a copy of MessageModel with updated fields
  MessageModel copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? recipientId,
    String? content,
    String? attachmentUrl,
    String? attachmentType,
    int? attachmentSize,
    String? thumbnailUrl,
    MessageType? type,
    MessageStatus? status,
    String? replyToMessageId,
    bool? isEdited,
    bool? isDeleted,
    bool? isForwarded,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? readAt,
    DateTime? deliveredAt,
    UserModel? sender,
    MessageModel? replyToMessage,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      content: content ?? this.content,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachmentType: attachmentType ?? this.attachmentType,
      attachmentSize: attachmentSize ?? this.attachmentSize,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      type: type ?? this.type,
      status: status ?? this.status,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      isEdited: isEdited ?? this.isEdited,
      isDeleted: isDeleted ?? this.isDeleted,
      isForwarded: isForwarded ?? this.isForwarded,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      readAt: readAt ?? this.readAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      sender: sender ?? this.sender,
      replyToMessage: replyToMessage ?? this.replyToMessage,
    );
  }

  /// Check if message has attachment
  bool get hasAttachment => attachmentUrl != null && attachmentUrl!.isNotEmpty;

  /// Check if message is media type
  bool get isMedia =>
      [MessageType.image, MessageType.video, MessageType.audio].contains(type);

  /// Check if message is read
  bool get isRead => status == MessageStatus.read;

  /// Check if message is delivered
  bool get isDelivered => status == MessageStatus.delivered || isRead;

  /// Check if message is sent
  bool get isSent =>
      status != MessageStatus.sending && status != MessageStatus.failed;

  /// Check if message failed to send
  bool get isFailed => status == MessageStatus.failed;

  /// Check if message is reply
  bool get isReply => replyToMessageId != null;

  /// Get formatted file size
  String get formattedFileSize {
    if (attachmentSize == null) return '';

    const units = ['B', 'KB', 'MB', 'GB'];
    double size = attachmentSize!.toDouble();
    int unitIndex = 0;

    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }

    return '${size.toStringAsFixed(1)} ${units[unitIndex]}';
  }

  /// Get time formatted string
  String get timeFormatted {
    final now = DateTime.now();
    final messageDate = createdAt;

    if (now.day == messageDate.day &&
        now.month == messageDate.month &&
        now.year == messageDate.year) {
      // Today - show time only
      return '${messageDate.hour.toString().padLeft(2, '0')}:${messageDate.minute.toString().padLeft(2, '0')}';
    } else if (now.difference(messageDate).inDays == 1) {
      // Yesterday
      return 'Yesterday';
    } else if (now.difference(messageDate).inDays < 7) {
      // This week - show day name
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[messageDate.weekday - 1];
    } else {
      // More than a week - show date
      return '${messageDate.day}/${messageDate.month}/${messageDate.year}';
    }
  }

  /// Get message preview text
  String get previewText {
    if (isDeleted) return 'This message was deleted';

    switch (type) {
      case MessageType.text:
        return content ?? '';
      case MessageType.image:
        return '📷 Photo';
      case MessageType.video:
        return '🎥 Video';
      case MessageType.audio:
        return '🎵 Audio';
      case MessageType.file:
        return '📄 File';
      case MessageType.location:
        return '📍 Location';
      case MessageType.story:
        return '📖 Story';
      case MessageType.post:
        return '📝 Post';
    }
  }

  /// Get status icon for message
  String get statusIcon {
    switch (status) {
      case MessageStatus.sending:
        return '⏳';
      case MessageStatus.sent:
        return '✓';
      case MessageStatus.delivered:
        return '✓✓';
      case MessageStatus.read:
        return '✓✓';
      case MessageStatus.failed:
        return '❌';
    }
  }

  /// Check if message can be edited
  bool get canEdit {
    if (isDeleted || type != MessageType.text) return false;
    final timeDiff = DateTime.now().difference(createdAt);
    return timeDiff.inMinutes <= 15; // Can edit within 15 minutes
  }

  /// Check if message can be deleted
  bool get canDelete => !isDeleted;

  /// Check if message can be replied to
  bool get canReply => !isDeleted;

  /// Check if message can be forwarded
  bool get canForward => !isDeleted && type != MessageType.location;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessageModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'MessageModel(id: $id, type: $type, status: $status)';
  }
}
