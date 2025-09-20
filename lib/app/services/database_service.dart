import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';
import '../utils/app_logger.dart';
import '../constants/app_constants.dart';

/// Database service for handling CRUD operations
class DatabaseService extends GetxService {
  late final SupabaseClient _supabase;

  @override
  void onInit() {
    super.onInit();
    _supabase = SupabaseService.client;
  }

  /// Generic method to fetch data from a table
  Future<List<Map<String, dynamic>>?> fetchData({
    required String table,
    String? select,
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    try {
      var query = _supabase.from(table).select(select ?? '*');

      // Apply filters
      if (filters != null) {
        filters.forEach((key, value) {
          if (value is List) {
            query = query.inFilter(key, value);
          } else {
            query = query.eq(key, value);
          }
        });
      }

      // Apply ordering, pagination etc.
      dynamic finalQuery = query;
      
      if (orderBy != null) {
        finalQuery = finalQuery.order(orderBy, ascending: ascending);
      }

      if (limit != null) {
        finalQuery = finalQuery.limit(limit);
      }
      
      if (offset != null) {
        finalQuery = finalQuery.range(offset, offset + (limit ?? AppConstants.defaultPageSize) - 1);
      }

      final response = await finalQuery;
      AppLogger.database('Fetched ${response.length} records from $table');
      return response;
    } catch (e) {
      AppLogger.error('Error fetching data from $table: $e');
      return null;
    }
  }

  /// Generic method to insert data into a table
  Future<Map<String, dynamic>?> insertData({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _supabase
          .from(table)
          .insert(data)
          .select()
          .single();
      
      AppLogger.database('Inserted data into $table');
      return response;
    } catch (e) {
      AppLogger.error('Error inserting data into $table: $e');
      return null;
    }
  }

  /// Generic method to update data in a table
  Future<Map<String, dynamic>?> updateData({
    required String table,
    required Map<String, dynamic> data,
    required Map<String, dynamic> filters,
  }) async {
    try {
      var query = _supabase.from(table).update(data);

      // Apply filters
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });

      final response = await query.select().single();
      AppLogger.database('Updated data in $table');
      return response;
    } catch (e) {
      AppLogger.error('Error updating data in $table: $e');
      return null;
    }
  }

  /// Generic method to delete data from a table
  Future<bool> deleteData({
    required String table,
    required Map<String, dynamic> filters,
  }) async {
    try {
      var query = _supabase.from(table).delete();

      // Apply filters
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });

      await query;
      AppLogger.database('Deleted data from $table');
      return true;
    } catch (e) {
      AppLogger.error('Error deleting data from $table: $e');
      return false;
    }
  }

  /// Get user profile by ID
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      
      AppLogger.database('Fetched user profile for $userId');
      return response;
    } catch (e) {
      AppLogger.error('Error fetching user profile: $e');
      return null;
    }
  }

  /// Update user profile
  Future<Map<String, dynamic>?> updateUserProfile({
    required String userId,
    required Map<String, dynamic> updates,
  }) async {
    return updateData(
      table: 'profiles',
      data: {
        ...updates,
        'updated_at': DateTime.now().toIso8601String(),
      },
      filters: {'id': userId},
    );
  }

  /// Get posts feed
  Future<List<Map<String, dynamic>>?> getPostsFeed({
    String? userId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      var query = _supabase
          .from('posts')
          .select('''
            *,
            profiles:user_id (
              id,
              username,
              display_name,
              avatar_url,
              is_verified
            ),
            post_likes:likes!inner (count),
            post_comments:comments (count)
          ''');

      if (userId != null) {
        query = query.eq('user_id', userId);
      }

      final response = await query
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      AppLogger.database('Fetched ${response.length} posts for feed');
      return response;
    } catch (e) {
      AppLogger.error('Error fetching posts feed: $e');
      return null;
    }
  }

  /// Create a new post
  Future<Map<String, dynamic>?> createPost({
    required String userId,
    required String content,
    List<String>? imageUrls,
    String? videoUrl,
    List<String>? hashtags,
  }) async {
    final postData = {
      'user_id': userId,
      'content': content,
      'image_urls': imageUrls,
      'video_url': videoUrl,
      'hashtags': hashtags,
      'likes_count': 0,
      'comments_count': 0,
      'shares_count': 0,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    return insertData(table: 'posts', data: postData);
  }

  /// Like/Unlike a post
  Future<bool> togglePostLike({
    required String postId,
    required String userId,
  }) async {
    try {
      // Check if like exists
      final existingLike = await _supabase
          .from('likes')
          .select()
          .eq('post_id', postId)
          .eq('user_id', userId)
          .maybeSingle();

      if (existingLike != null) {
        // Unlike the post
        await _supabase
            .from('likes')
            .delete()
            .eq('post_id', postId)
            .eq('user_id', userId);

        // Decrement likes count
        await _supabase.rpc('decrement_likes_count', params: {'post_id': postId});
        
        AppLogger.database('Post unliked');
        return false;
      } else {
        // Like the post
        await _supabase.from('likes').insert({
          'post_id': postId,
          'user_id': userId,
          'created_at': DateTime.now().toIso8601String(),
        });

        // Increment likes count
        await _supabase.rpc('increment_likes_count', params: {'post_id': postId});
        
        AppLogger.database('Post liked');
        return true;
      }
    } catch (e) {
      AppLogger.error('Error toggling post like: $e');
      return false;
    }
  }

  /// Add comment to post
  Future<Map<String, dynamic>?> addComment({
    required String postId,
    required String userId,
    required String content,
    String? parentCommentId,
  }) async {
    final commentData = {
      'post_id': postId,
      'user_id': userId,
      'content': content,
      'parent_comment_id': parentCommentId,
      'likes_count': 0,
      'replies_count': 0,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    final result = await insertData(table: 'comments', data: commentData);
    
    if (result != null) {
      // Increment comments count
      await _supabase.rpc('increment_comments_count', params: {'post_id': postId});
    }

    return result;
  }

  /// Get comments for a post
  Future<List<Map<String, dynamic>>?> getPostComments({
    required String postId,
    int limit = 20,
    int offset = 0,
  }) async {
    return fetchData(
      table: 'comments',
      select: '''
        *,
        profiles:user_id (
          id,
          username,
          display_name,
          avatar_url,
          is_verified
        )
      ''',
      filters: {'post_id': postId},
      orderBy: 'created_at',
      ascending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Follow/Unfollow a user
  Future<bool> toggleUserFollow({
    required String followerId,
    required String followingId,
  }) async {
    try {
      // Check if follow relationship exists
      final existingFollow = await _supabase
          .from('follows')
          .select()
          .eq('follower_id', followerId)
          .eq('following_id', followingId)
          .maybeSingle();

      if (existingFollow != null) {
        // Unfollow
        await _supabase
            .from('follows')
            .delete()
            .eq('follower_id', followerId)
            .eq('following_id', followingId);

        // Update counts
        await _supabase.rpc('decrement_following_count', params: {'user_id': followerId});
        await _supabase.rpc('decrement_followers_count', params: {'user_id': followingId});
        
        AppLogger.database('User unfollowed');
        return false;
      } else {
        // Follow
        await _supabase.from('follows').insert({
          'follower_id': followerId,
          'following_id': followingId,
          'created_at': DateTime.now().toIso8601String(),
        });

        // Update counts
        await _supabase.rpc('increment_following_count', params: {'user_id': followerId});
        await _supabase.rpc('increment_followers_count', params: {'user_id': followingId});
        
        AppLogger.database('User followed');
        return true;
      }
    } catch (e) {
      AppLogger.error('Error toggling user follow: $e');
      return false;
    }
  }

  /// Search users
  Future<List<Map<String, dynamic>>?> searchUsers({
    required String query,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .or('username.ilike.%$query%,display_name.ilike.%$query%')
          .order('followers_count', ascending: false)
          .range(offset, offset + limit - 1);

      AppLogger.database('Searched users with query: $query');
      return response;
    } catch (e) {
      AppLogger.error('Error searching users: $e');
      return null;
    }
  }

  /// Search posts
  Future<List<Map<String, dynamic>>?> searchPosts({
    required String query,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _supabase
          .from('posts')
          .select('''
            *,
            profiles:user_id (
              id,
              username,
              display_name,
              avatar_url,
              is_verified
            )
          ''')
          .textSearch('content', query)
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      AppLogger.database('Searched posts with query: $query');
      return response;
    } catch (e) {
      AppLogger.error('Error searching posts: $e');
      return null;
    }
  }

  /// Get user's followers
  Future<List<Map<String, dynamic>>?> getUserFollowers({
    required String userId,
    int limit = 20,
    int offset = 0,
  }) async {
    return fetchData(
      table: 'follows',
      select: '''
        follower_id,
        profiles:follower_id (
          id,
          username,
          display_name,
          avatar_url,
          is_verified,
          followers_count
        )
      ''',
      filters: {'following_id': userId},
      orderBy: 'created_at',
      ascending: false,
      limit: limit,
      offset: offset,
    );
  }

  /// Get user's following
  Future<List<Map<String, dynamic>>?> getUserFollowing({
    required String userId,
    int limit = 20,
    int offset = 0,
  }) async {
    return fetchData(
      table: 'follows',
      select: '''
        following_id,
        profiles:following_id (
          id,
          username,
          display_name,
          avatar_url,
          is_verified,
          followers_count
        )
      ''',
      filters: {'follower_id': userId},
      orderBy: 'created_at',
      ascending: false,
      limit: limit,
      offset: offset,
    );
  }
}