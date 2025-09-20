import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Get conversation data from arguments
  late Map<String, dynamic> conversation;
  
  // Mock messages data
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    conversation = Get.arguments ?? {};
    _initializeMessages();
  }

  void _initializeMessages() {
    messages = [
      {
        'id': 'msg1',
        'text': 'Hey! How are you doing?',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'isFromMe': false,
        'type': 'text',
      },
      {
        'id': 'msg2',
        'text': 'I\'m good! Just finished work. How about you?',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2, minutes: 55)),
        'isFromMe': true,
        'type': 'text',
      },
      {
        'id': 'msg3',
        'text': 'Great! I\'m planning a weekend trip. Want to join?',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        'isFromMe': false,
        'type': 'text',
      },
      {
        'id': 'msg4',
        'text': 'That sounds amazing! Where are you thinking of going?',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
        'isFromMe': true,
        'type': 'text',
      },
      {
        'id': 'msg5',
        'text': 'I was thinking about the mountains. The weather should be perfect!',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
        'isFromMe': false,
        'type': 'text',
      },
      {
        'id': 'msg6',
        'text': 'Perfect! Count me in 🏔️',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 25)),
        'isFromMe': true,
        'type': 'text',
      },
    ];
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          'id': 'msg${messages.length + 1}',
          'text': _messageController.text.trim(),
          'timestamp': DateTime.now(),
          'isFromMe': true,
          'type': 'text',
        });
      });
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
    
    if (messageDate == today) {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.day}/${timestamp.month} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = conversation['user'] ?? {
      'username': 'User',
      'profileImage': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user['profileImage']),
                ),
                if (user['isOnline'])
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['username'] ?? 'User',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (user['isOnline'])
                    Text(
                      'Active now',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle video call
            },
            icon: const Icon(Icons.videocam, color: Colors.black87),
          ),
          IconButton(
            onPressed: () {
              // Handle voice call
            },
            icon: const Icon(Icons.call, color: Colors.black87),
          ),
          IconButton(
            onPressed: () {
              // Handle more options
            },
            icon: const Icon(Icons.more_vert, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isFromMe = message['isFromMe'];
                final showTimestamp = index == 0 || 
                    messages[index - 1]['timestamp'].difference(message['timestamp']).inMinutes.abs() > 5;
                
                return Column(
                  children: [
                    if (showTimestamp)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          _formatTimestamp(message['timestamp']),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: isFromMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isFromMe) ...[
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(user['profileImage']),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isFromMe
                                    ? const Color(0xFF007AFF)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 5,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                message['text'],
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: isFromMe ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          if (isFromMe) const SizedBox(width: 40),
                          if (!isFromMe) const SizedBox(width: 40),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          
          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle add photo/media
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.grey[600],
                      size: 28,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.grey[600],
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}