import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_constants.dart';

class PostCard extends StatefulWidget {
  final Map<String, dynamic> post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onBookmark;
  final VoidCallback? onProfileTap;

  const PostCard({
    super.key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onBookmark,
    this.onProfileTap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with SingleTickerProviderStateMixin {
  late AnimationController _likeAnimationController;
  late Animation<double> _likeAnimation;
  bool _showLikeAnimation = false;

  @override
  void initState() {
    super.initState();
    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _likeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _likeAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (!widget.post['isLiked']) {
      widget.onLike?.call();
      setState(() {
        _showLikeAnimation = true;
      });
      _likeAnimationController.forward().then((_) {
        _likeAnimationController.reverse().then((_) {
          setState(() {
            _showLikeAnimation = false;
          });
        });
      });
    }
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
    final user = widget.post['user'] as Map<String, dynamic>;
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.smallPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onProfileTap,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: user['isVerified'] 
                          ? AppColors.primaryGradient 
                          : null,
                      border: user['isVerified'] 
                          ? null 
                          : Border.all(color: AppColors.borderColor, width: 2),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(user['profileImage']),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: widget.onProfileTap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              user['displayName'],
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            if (user['isVerified']) ...[
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.verified,
                                color: AppColors.primaryColor,
                                size: 16,
                              ),
                            ],
                          ],
                        ),
                        Text(
                          '@${user['username']}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  timeago.format(widget.post['createdAt']),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColors.textSecondary,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'report',
                      child: Row(
                        children: [
                          Icon(Icons.flag_outlined),
                          SizedBox(width: 8),
                          Text('Report'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'block',
                      child: Row(
                        children: [
                          Icon(Icons.block_outlined),
                          SizedBox(width: 8),
                          Text('Block User'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'share',
                      child: Row(
                        children: [
                          Icon(Icons.share_outlined),
                          SizedBox(width: 8),
                          Text('Share Post'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Content
          if (widget.post['content'] != null && widget.post['content'].isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: Text(
                widget.post['content'],
                style: AppTextStyles.bodyMedium.copyWith(
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          
          // Image/Video
          if (widget.post['imageUrl'] != null) ...[
            GestureDetector(
              onDoubleTap: _handleDoubleTap,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxHeight: 400,
                    ),
                    child: Image.network(
                      widget.post['imageUrl'],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 300,
                          color: AppColors.surfaceColor,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 300,
                          color: AppColors.surfaceColor,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              size: 50,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_showLikeAnimation)
                    Positioned.fill(
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _likeAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _likeAnimation.value,
                              child: Icon(
                                Icons.favorite,
                                color: AppColors.likeColor,
                                size: 80,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
          
          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    // Like Button
                    GestureDetector(
                      onTap: widget.onLike,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(
                              widget.post['isLiked'] 
                                  ? Icons.favorite 
                                  : Icons.favorite_border,
                              color: widget.post['isLiked'] 
                                  ? AppColors.likeColor 
                                  : AppColors.textSecondary,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatCount(widget.post['likesCount']),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: widget.post['isLiked'] 
                                    ? AppColors.likeColor 
                                    : AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Comment Button
                    GestureDetector(
                      onTap: widget.onComment,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              color: AppColors.textSecondary,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatCount(widget.post['commentsCount']),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Share Button
                    GestureDetector(
                      onTap: widget.onShare,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              color: AppColors.textSecondary,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatCount(widget.post['sharesCount']),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Bookmark Button
                    GestureDetector(
                      onTap: widget.onBookmark,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          widget.post['isBookmarked'] 
                              ? Icons.bookmark 
                              : Icons.bookmark_border,
                          color: widget.post['isBookmarked'] 
                              ? AppColors.primaryColor 
                              : AppColors.textSecondary,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}